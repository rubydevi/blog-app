class LikesController < ApplicationController
  before_action :set_post

  def new
    @like = Like.new
  end

  def create
    @like = Like.new
    @like.post = @post
    @like.user = current_user

    if @like.save
      flash[:notice] = 'Like was successfully created.'
      redirect_to user_post_path(@like.post.author_id, @like.post.id)
    else
      flash.now[:error] = 'Oops, something went wrong'
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
