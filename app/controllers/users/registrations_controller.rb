class Users::RegistrationsController < Devise::RegistrationsController
	before_action :check_guest, only: %i[update destroy]

	def check_guest
		binding.pry
	    if resource.email == 'guest@example.jp'
	      redirect_to work_outs_path, alert: 'ゲストユーザーの変更・削除はできません。'
	    end
	  end

	def after_sign_in_path_for(_resource)
		work_outs_path
	end

	def after_sign_out_path_for(_resource)
		root_path
	end
end
