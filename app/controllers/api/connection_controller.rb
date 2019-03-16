# frozen_string_literal: true

module Api
  # Provides an endpoint, that tracks all initiated connections to the server.
  # The same as other for API controllers, it checks signature and server status.
  class ConnectionController < Api::BaseController
    before_action :valid_api_call?

    def connect
      connect_object = connector.invoke
      # TODO: investigate if it is fixed
      # am:serializers temporary don't work with rails 4.2
      # render status: 200, json: connect_object, serializer: Api::ConnectSerializer
      render status: 200, json: Api::ConnectSerializer.new(connect_object).to_json
    end

    def disconnect
      disconnect_object = connector.invoke
      # render status: 200, json: disconnect_object, serializer: Api::DisconnectSerializer
      render status: 200, json: Api::DisconnectSerializer.new(disconnect_object).to_json
    end

    private

    def connector
      Connector.new(action_params)
    end

    def action_params
      {
        login: params[:login],
        hostname: params[:hostname],
        traffic_in: params[:traffic_in],
        traffic_out: params[:traffic_out],
        action: params[:action]
      }
    end
  end
end
