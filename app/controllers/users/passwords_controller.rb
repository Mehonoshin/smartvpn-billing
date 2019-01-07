# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  layout 'blank'

  def after_sign_in_path_for(_resource)
    billing_root_path
  end

  def after_sending_reset_password_instructions_path_for(_resource_name)
    new_user_session_path
  end
end
