class PostsController < ApplicationController
  before_action :logged_in_user, only: [:home, :index, :new, :edit]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def home
    @home_posts = Post.posts_all
    @following = current_user.following
    @posts = @home_posts.where(user_id: @following).or(@home_posts.where(user_id: current_user))
    @users = User.where.not(id: current_user.id).sample(3)
    @comment = Comment.new
  end

  def index
    @posts = Post.posts_all
    @users = User.where.not(id: current_user.id).sample(4)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_path
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Task was successfully updated.'
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit!
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@post.user)
  end

end
