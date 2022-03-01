class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[show edit update destroy favorites]
  before_action :check_user, only: %i[edit update destroy]
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "アカウント作成しました!"
    else
      render :new
    end
  end
  def show
    @blog=@user.blogs
    favorites = Favorite.where(user_id: current_user.id).pluck(:blog_id)
    @favorite_blogs = Blog.find(favorites)
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー情報を編集しました!"
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    flash[:danger] = "退会しました!"
    redirect_to new_user_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email,
      :password, :password_confirmation,:title,:content)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def check_user
    if @user.id != current_user.id
      flash[:danger] = "編集できません!"
      redirect_back(fallback_location: @user)
    end
  end
end
