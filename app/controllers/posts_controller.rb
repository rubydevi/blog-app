def index
  @user = User.includes(posts: :comments).find(params[:user_id])
  @posts = @user.posts.includes(:comments)

  respond_to do |format|
    format.html { render 'index' }
    format.json { render json: @posts }
  end
end
