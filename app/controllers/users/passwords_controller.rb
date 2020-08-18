class Users::PasswordsController < Devise::PasswordsController
	before_action :check_guest, only: :create

	def check_guest
		if params[:user][:email].downcase == 'guest@example.jp'
		  redirect_to work_outs_path, alert: 'ゲストユーザーの変更・削除はできません。'
		end
	end
end
