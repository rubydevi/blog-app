class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_current_user, only: %i[new create destroy]

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @posts }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @post = @user.posts.build
  end

  def create
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
    @post = @user.posts.find(params[:id])

    if @post.destroy
      flash.now[:success] = "Your post titled: '#{@post.title}' was successfully deleted"
    else
      flash.now[:error] = 'Oops! Cannot delete your post.'
    end
    redirect_to user_posts_path(@user)
  end

  private

  def set_current_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
