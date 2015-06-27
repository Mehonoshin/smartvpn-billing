class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def valid_api_call?
    raise ApiException, "Server not found" unless server
    raise ApiException, "Server not active" unless server.active?
    raise ApiException, "Invalid api call" unless valid_signature?
  end

  def server
    Server.where(hostname: params[:hostname], ip_address: request.remote_ip).last
  end

  def valid_signature?
    signature == Signer.sign_hash(clean_params, server.auth_key)
  end

  def clean_params
    attrs = params.dup
    ["controller", "action", "signature"].each { |param| attrs.delete(param) }
    attrs
  end

  def signature
    params[:signature]
  end

end
