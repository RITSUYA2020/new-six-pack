class WorkOutsController < ApplicationController
   before_action :authenticate_user!

  def index
    @work_outs = WorkOut.page(params[:page]).per(5).reverse_order
    #タグ絞り込み
    if params[:tag_name]
      @work_outs = WorkOut.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @work_out = WorkOut.find(params[:id])
    @user = @work_out.user
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |current_user|
        @user_entry.each do |user|
          if current_user.room_id == user.room_id then
            @isRoom = true
            @roomId = current_user.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @new_comment = Comment.new
    @favorite_users = @work_out.favorite_users
  end

  def edit
    @work_out = WorkOut.find(params[:id])
  end

  def update
    @work_out = WorkOut.find(params[:id])
    if @work_out.update(work_out_params)
      flash[:notice] = '編集を保存しました。'
      redirect_to work_out_path(@work_out)
    else
      flash[:error] = '(必須)の項目を入力してください。'
      render "edit"
    end
  end

  def destroy
    work_out = WorkOut.find(params[:id])
    if work_out.destroy
      flash[:alert] = '投稿を削除しました。'
      redirect_to work_outs_path
    end
  end

  def new
    @work_out = WorkOut.new
  end

  def create
    @work_out = WorkOut.new(work_out_params)
    @work_out.user_id = current_user.id
    if @work_out.save
      flash[:notice] = '投稿が完了しました。'
      redirect_to work_out_path(@work_out)
    else
      flash[:error] = '(必須)の項目を入力してください。'
      render "new"
    end
  end

  def search
    @work_outs = WorkOut.where(muscle_group: params[:search_target]).page(params[:page]).per(5).reverse_order
    #word = params[:search_word]
    #@work_outs = WorkOut.search(word)
  end

  #フォローしているユーザーのみタイムラインに表示
  def following
    @work_outs_all = WorkOut.page(params[:page]).per(5)
    @user = User.find(current_user.id)
    #フォローしているユーザーを取得
    @followings = @user.followings
    #フォローしているユーザーのツイートを表示
    @work_outs = @work_outs_all.where(user_id: @followings).reverse_order.page(params[:page]).per(10)
  end

  private
  def work_out_params
    params.require(:work_out).permit(:time, :muscle_group, :equipment, :body, :effect, :place, :before_image, :after_image, :tag_list)
  end
end
