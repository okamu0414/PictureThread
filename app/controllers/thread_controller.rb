class ThreadController < ApplicationController
  def index
    @threads = AddThread.all 
    #スレッドテーブルの中身を配列にまとめて返してます。
  end
  
  def show
    @thread = AddThread.find_by(id: params[:thread_id])
    #threadにアクセスしようとしているスレッドのインスタンスを挿入
    
    @posts = Post.where(thread_name: @thread.thread_name)
    @posts = @posts.order(id: "DESC") #降順=新着順
    #@postsにすべての投稿の内のスレッド名カラムが
    #threadのスレッド名であるインスタンスを配列で返す
    
  end
  
  def like_sort
    @thread = AddThread.find_by(id: params[:thread_id])
    #threadにアクセスしようとしているスレッドのインスタンスを挿入
    
    @posts = Post.where(thread_name: @thread.thread_name)
    @posts = @posts.order(id: "DESC") #降順=新着順
    #@postsにすべての投稿の内のスレッド名カラムが
    #threadのスレッド名であるインスタンスを配列で返す
    @posts.each do |post|
      post.like_count = Like.where(post_id: post.id).count
      post.save
    end
    @posts = Post.where(thread_name: @thread.thread_name).order(like_count: "DESC") #いいね順
      
  end
  
  
  def create
    @newthread = AddThread.new
  end
  
  def new
    @newthread = AddThread.new(
        thread_name: params[:thread_name],
        user_name: @current_user.name,
        thread_image_name: "default.png",
        create_user_id: @current_user.id
      )
    if @newthread.save
      image = params[:image]
      if image
        @newthread.thread_image_name = "#{@newthread.id}.png"
        @newthread.save
        File.binwrite(
        "public/thread_images/test_images/#{@newthread.thread_image_name}",
        image.read
        )
      end
      redirect_to("/thread/index")
    else
      render("thread/create")
    end
  end
  
  def image_edit
    @thread = AddThread.find_by(id: params[:thread_id])
    
  end
  
  def image_changed
    @thread = AddThread.find_by(id: params[:thread_id])
    image = params[:image]
    @thread.thread_image_name = "#{@thread.id}.png"
    @thread.save
    File.binwrite("public/thread_images/test_images/#{@thread.thread_image_name}",image.read)
    redirect_to("/thread/index")
  end
  
  def destroy
    thread = AddThread.find_by(id: params[:thread_id])
    posts = Post.where(thread_name: thread.thread_name)
    posts.each do |post| #消すスレッドの全投稿を削除してまーす
      File.delete("public/thread_images/main_images/#{post.image_name}") #まず該当投稿の写真を削除！
      likes = Like.where(post_id: post.id) #該当投稿のいいねも全部削除！
      likes.each do |like| #likes入ったいいね履歴をlikeに入れてループです
        like.destroy #likeを削除！
      end
      post.destroy #そして該当投稿のレコードも削除！
    end
    File.delete("public/thread_images/test_images/#{thread.thread_image_name}")
    thread.destroy #ついにスレッド削除！
    redirect_to("/thread/index")
  end
  
end
