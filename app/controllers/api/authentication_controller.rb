class Api::AuthenticationController < Api::BaseController
  before_action :valid_api_call?

  def auth
    authenticator = Authenticator.new(params[:login], params[:password], params[:hostname])
    if authenticator.valid_credentials?
      render status: 200, nothing: true
    else
      render status: 404, nothing: true
    end
  end
end

