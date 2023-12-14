class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post

  # GET /comments
  # GET /comments.json
  # Fetches all comments for a specific post and renders them in HTML or JSON format.
  def index
    @comments = @post.comments
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @comments }
    end
  end

  # GET /comments/new
  # Initializes a new comment object.
  def new
    @comment = Comment.new
  end

  # POST /comments
  # Creates a new comment for a specific post.
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

  # DELETE /comments/:id
  # Deletes a comment for a specific post.
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

  # Sets the @post instance variable based on the post_id parameter.
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Defines the permitted parameters for creating a comment.
  def comment_params
    params.require(:comment).permit(:text)
  end
end
