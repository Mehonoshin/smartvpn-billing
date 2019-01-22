class ApiException < Exception; end

class Api::ServersController < Api::BaseController
  # TODO: most probably it should be a separate service
  def activate
    if request_ip == server.ip_address
      raise ApiException, "Already activated server #{request_ip} #{server.hostname}" if server.active?
      server.update!(activation_params)
      server.activate!
      render json: { auth_key: server.auth_key }.to_json
    else
      raise ApiException, "Server activation attempt from incorrect ip: #{request_ip}"
    end
  end

  private

  def request_ip
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def server
    Server.find_by(hostname: params[:hostname]) || raise(ApiException, "Server for activation not found")
  end

  def activation_params
    params.permit(:server_crt, :client_crt, :client_key)
  end
end
