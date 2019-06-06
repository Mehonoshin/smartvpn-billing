# frozen_string_literal: true

module Api
  # Provides endpoint for authentication API calls.
  # Whenever server gets incoming connection request, it should ask
  # billing whether it should allow client to connect.
  #
  # Billing checks multiple parameters, like server existence and status,
  # if the plan allows to connect to this specific server and many more.
  class AuthenticationController < Api::BaseController
    before_action :valid_api_call?

    def auth
      authenticator = Authenticator.new(params[:login], params[:password], params[:hostname])
      if authenticator.valid_credentials?
        render status: 200, body: nil
      else
        render status: 404, body: nil
      end
    end
  end
end
