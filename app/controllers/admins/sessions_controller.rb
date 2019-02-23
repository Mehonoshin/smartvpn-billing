# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  layout 'blank'

  def after_sign_out_path_for(_resource)
    new_admin_session_path
  end

  def after_sign_in_path_for(_resource)
    admin_root_path
  end

  def resource_params
    params.require(:user).permit(:admin, :email, :password, :remember_me)
  end

  private :resource_params
end
