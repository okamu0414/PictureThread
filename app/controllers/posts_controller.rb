class PostsController < ApplicationController
  def index
  end
  
  def show #showはthread/showで画像をタップしたときの遷移先です
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id) #投稿ユーザのインスタンス
    @like = Like.find_by(user_id: @current_user.id,post_id: @post.id) #この投稿をいいねしているか判別
  end
  
  def create
    @thread = AddThread.find_by(id: params[:thread_id])
    @post = Post.new
  end
  
  def new
    @thread = AddThread.find_by(id: params[:thread_id])

    # @post = Post.create params.require(:post).permit(user_id: @current_user.id, thread_name: @thread.thread_name, :image)

  # if params[:image].nil?
  #   render("posts/create")
  # else
    @post = Post.new(
      user_id: @current_user.id,
      thread_name: @thread.thread_name
    )
    @post.image.attach(params[:post][:image])

    if @post.save
      # @post.create(post_params)
      # @post.image.attach(params[:post][:image])
      redirect_to("/thread/#{@thread.id}")
    else
      render("posts/create")
    end

  # end

  end
  
  def destroy
    post = Post.find_by(id: params[:id])
    likes = Like.where(post_id: post.id)
    thread = AddThread.find_by(thread_name: post.thread_name)
    likes.each do |like|
      like.destroy
    end
    post.image.purge
    redirect_to("/thread/#{thread.id}")
    # File.delete("public/thread_images/main_images/#{post.image_name}")
    #↑ActiveStorageのためにコメントにした
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :thread_name, :image)
    end


end
