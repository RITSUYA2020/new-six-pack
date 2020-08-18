class Users::SessionsController < Devise::SessionsController

	before_action :reject_user, only: [:create]

	def new_guest
		user = User.guest
		sign_in user
		redirect_to work_outs_path, notice: 'ゲストユーザーとしてログインしました。'
	end

	def after_sign_in_path_for(_resource)
		work_outs_path
	end

	def after_sign_out_path_for(_resource)
		root_path
	end

	protected
	def reject_user
		@user = User.find_by(email: params[:user][:email].downcase) #downcaseメソッドは大文字を小文字に変換するメソッド
		if @user
			if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
				flash[:error] = "退会済みです。"
				redirect_to new_user_session_path
			end
		end
	end

end
