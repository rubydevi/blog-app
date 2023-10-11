class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = Post.new(
      author: @user,
      title: params[:post][:title],
      text: params[:post][:text],
      comments_counter: 0,
      likes_counter: 0
    )

    if @post.save
      flash.now[:error] = 'Post was successfully created.'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Oops, something went wrong'
      render :new
    end
  end

  def destroy
    @user = current_user
    @post = @user.posts.find(params[:id])
    authorize! :destroy, @post
    if @post.destroy
      flash.now[:success] = "Your post titled: '#{@post.title}' was successfully deleted"
    else
      flash.now[:error] = 'Oops! Cannot delete your post.'
    end
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end