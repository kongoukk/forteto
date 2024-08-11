class Public::UsersController < ApplicationController
# ユーザーコントローラー未作成


before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @post = Post.new
  end

  def show
    # @user = User.find(params[:id])
    # @post = @user.posts
    # @post = Post.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def guest_sign_in
    user = User.find_or_create_by(email: "guest@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: "ゲストログインしました。"
  end
end
