class Users::RegistrationsController < Devise::RegistrationsController
  before_action :add_referrer_id_to_params, only: [:create]
  before_action :set_additional_permitted_params, only: [:create]
  layout :resolve_layout

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  private

  def set_additional_permitted_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:plan_id, :accept_agreement, :email, :password, 
               :password_confirmation, :referrer_id)
    end
  end

  def resolve_layout
    if ['edit', 'update'].include?(action_name)
      'billing'
    else
      'blank'
    end
  end

  def current_referrer
    User.where(reflink: cookies[:reflink]).last
  end

  def add_referrer_id_to_params
    params[:user].merge!({ referrer_id: current_referrer.id }) if current_referrer
  end
end
