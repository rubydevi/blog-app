class CommentsController < ApplicationController
  before_action :set_post
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to user_post_path(@comment.post.author_id, @comment.post.id)
    else
      flash.now[:error] = 'Oops, something went wrong'
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
