class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # 「current_userに関連したFavoriteクラスの新しいインスタンス」が作成可能。
    # 　つまり、favorite.user_id = current_user.idが済んだ状態で生成されている。
    # 　buildはnewと同じ意味で、アソシエーションしながらインスタンスをnewする時に形式的に使われる。
    favorite = current_user.favorites.build(work_out_id: params[:work_out_id])
    favorite.save
    @work_out = WorkOut.find(params[:work_out_id])
    # 通知の作成
    @work_out.create_notification_by(current_user)
  end

  def destroy
    @work_out = WorkOut.find(params[:work_out_id])
    favorite = Favorite.find_by(work_out_id: params[:work_out_id], user_id: current_user.id)
    favorite.destroy
  end

  def show
    @user = User.find(params[:user_id])
    @favorite_work_outs = @user.favorite_work_outs.page(params[:page]).per(5).reverse_order
  end
end
