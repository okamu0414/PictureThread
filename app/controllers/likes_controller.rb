class LikesController < ApplicationController
  def likes
  end
  
  def create
    @post = Post.find_by(id: params[:post_id])
    @like = Like.new(
        user_id: @current_user.id,
        post_id: @post.id
      )
    @like.save
    redirect_to("/posts/#{@post.id}")
  end
  
  def destroy
    @post = Post.find_by(id: params[:post_id])
    @like = Like.find_by(post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{@post.id}")
  end
  
end
