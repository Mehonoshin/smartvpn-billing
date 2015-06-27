class Users::PasswordsController < Devise::PasswordsController
  layout 'blank'

  def after_sign_in_path_for(resource)
    billing_root_path
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end
