# frozen_string_literal: true

# Provides an API endpoint for server activation.
# Whenever a new server wants to register in billing, it sends all information
# about itself to `activate` action.
# The request should be signed with billing's secret token.
class Api::ServersController < Api::BaseController
  # TODO: most probably it should be a separate service
  def activate
    raise ApiException, "Server already exists: #{server}" if server
    raise ApiException, "Server activation attempt with incorrect token: #{signature}" unless valid_signature?

    server = Server.create!(initialization_params)
    server.activate!
    render json: { auth_key: server.auth_key }.to_json
  end

  private

  def initialization_params
    # TODO: make a proper default for country code
    params
      .permit(
        :server_crt, :client_crt, :client_key,
        :port, :protocol
      ).merge(ip_address: request_ip, country_code: :us, hostname: request_ip)
  end
end
