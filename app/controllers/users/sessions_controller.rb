class Users::SessionsController < Devise::SessionsController
  layout "blank"

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    flash[:alert] = nil if flash[:alert] == I18n.t("devise.failure.already_authenticated")
    billing_root_path
  end

  def resource_params
    params.require(:user).permit(:user, :email, :password, :remember_me)
  end

  private :resource_params
end
