class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post

  def index
    @comments = @post.comments
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@comment.post.author_id, @comment.post.id) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

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
