class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest, only: %i[update withdraw]

  def show
    @user = User.find(params[:id])
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |current_user|
        @user_entry.each do |user|
          if current_user.room_id == user.room_id
            @isRoom = true
            @roomId = current_user.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    @work_outs = @user.work_outs.includes(:taggings).reverse_order
    @new_todo = Todo.new
    @todos = Todo.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'プロフィールを更新しました。'
      redirect_to user_path(current_user)
    else
      flash[:error] = '名前とメールアドレスを入力してください。'
      render 'edit'
    end
  end

  def confirm
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムにフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to root_path
  end

  # 自分がフォローしているユーザー一覧
  def follows
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  # 自分をフォローしているユーザー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def check_guest
    user = User.find(params[:id])
    if user.email == 'guest@user.com'
      flash[:alert] = 'ゲストユーザーの変更・削除はできません。'
      redirect_to work_outs_path
    end
  end

  def index
    @users = User.all
    @search = User.ransack(params[:q])
  end

  def search
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :sex, :encrypted_password, :is_deleted)
  end
end
