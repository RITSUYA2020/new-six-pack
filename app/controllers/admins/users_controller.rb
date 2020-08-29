class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました。'
      redirect_to admins_users_path
    else
      flash[:error] = '名前とメールアドレスを入力してください。'
      render 'edit'
       end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :sex, :encrypted_password, :is_deleted)
  end
end
