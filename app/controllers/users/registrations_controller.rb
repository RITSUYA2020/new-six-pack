class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(_resource)
    work_outs_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end
end
