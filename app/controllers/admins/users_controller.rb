class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = User.ransack(params[:q])
    unless params[:q]
      @users = User.all
    else
      @users = @q.result(distinct: true)
    end
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

  def graph
    # 今月の初めから今日までを配列にする
    days = (Date.today.beginning_of_month..Date.today).to_a
    # 今月の初めから今日までの配列を取得し、今日ユーザーが登録したレコードを探して数える
        # 配列の入った変数.map {|変数名| 処理内容 }
    users = days.map { |item| User.where(created_at: item.beginning_of_day..item.end_of_day).count }

    @chart = LazyHighCharts::HighChart.new('graph') do |c|
      c.title(text: "今月のユーザー登録推移")
      # x軸
      c.xAxis( # x軸の設定
        title: { # x軸のタイトル
          text: '日付'
            }
          )
      # y軸
      c.yAxis( # y軸の設定
            title: { # y軸のタイトル
                text: '人数'
                }
            )
      c.series( # グラフの中身（データの設定）
        name: '登録数', #各データの名前
          data: users # 各データ(数値)
          )
    end
  end

  def rank
    @ranks = User.create_all_ranks
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :sex, :encrypted_password, :is_deleted)
  end
end
