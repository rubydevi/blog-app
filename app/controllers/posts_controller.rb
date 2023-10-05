class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
