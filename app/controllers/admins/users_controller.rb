class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    respond_to do |format|
      format.html # html用の処理を書く
      format.csv do # csv用の処理を書く
        send_data render_to_string, filename: "ユーザー一覧.csv", type: :csv
      end
    end
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
