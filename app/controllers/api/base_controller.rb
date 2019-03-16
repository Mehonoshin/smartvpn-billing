# frozen_string_literal: true

class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def valid_api_call?
    raise ApiException, 'Server not found' unless server
    raise ApiException, 'Server not active' unless server.active?
    raise ApiException, 'Invalid api call' unless valid_signature?
  end

  def server
    Server.find_by(hostname: params[:hostname])
  end

  def request_ip
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def valid_signature?
    Server::Signature.new(server, params).valid?
  end

  def signature
    params[:signature]
  end
end
