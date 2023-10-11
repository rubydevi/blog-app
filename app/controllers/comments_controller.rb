class CommentsController < ApplicationController
  load_and_authorize_resource
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

  def destroy
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    if @comment.destroy
      flash[:success] = 'Comment was successfully deleted'
    else
      flash[:error] = 'Oops! Cannot delete your comment.'
    end
    redirect_to user_post_path(@post.author_id, @post.id)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
