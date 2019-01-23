# frozen_string_literal: true

class ApiException < RuntimeError; end

class Api::ServersController < Api::BaseController
  # TODO: most probably it should be a separate service
  def activate
    raise ApiException, 'Server activation attempt with incorrect token' unless valid_activation_token?
    raise ApiException, "Already activated server #{request_ip} #{server.hostname}" if server.active?

    server.update!(activation_params)
    server.activate!
    render json: { auth_key: server.auth_key }.to_json
  end

  private

  def request_ip
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def server
    Server.find_by(hostname: params[:hostname]) || raise(ApiException, 'Server for activation not found')
  end

  def valid_activation_token?
    params[:secret_token].to_s == Settings.secret_token.to_s
  end

  def activation_params
    params.permit(:server_crt, :client_crt, :client_key)
  end
end
