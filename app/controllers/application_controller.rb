class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to billing_root_path, alert: exception.message
  end

  rescue_from UnauthorizedException do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  rescue_from AdminAccessDeniedException do |exception|
    redirect_to new_admin_session_path
  end
end
