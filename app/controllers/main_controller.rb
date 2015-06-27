class MainController < ApplicationController

  def index
    if signed_in? && current_user
      redirect_to billing_root_path
    else
      redirect_to new_user_session_path
    end
  end
end
