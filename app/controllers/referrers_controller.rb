class ReferrersController < ApplicationController
  def set_referrer
    cookies[:reflink] = reflink
    redirect_to root_path
  end

  private

  def reflink
    params[:code]
  end
end
