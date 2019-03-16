# Allows to check if the request from the server is valid.
# Server may be nil, which means that it does not exist in billing yet.
# In this case we check if the secret key is equal to the secret key of application.
# This kind of check is used just once, when we initialize the server in bulling.
#
# All other requests from server to API should be signed by unique erver auth key, which
# is generated on server initialization.
class Server
  class Signature
    IGNORED_PARAMS = %w[controller action signature]

    attr_reader :server, :request_params

    def initialize(server, request_params)
      @server         = server
      @request_params = request_params.with_indifferent_access
    end

    def valid?
      if server
        signature == Signer.sign_hash(clean_params, server.auth_key)
      else
        signature == Settings.secret_token
      end
    end

    private

    def signature
      request_params[:signature]
    end

    def clean_params
      IGNORED_PARAMS.reduce(request_params.dup) do |attrs, param|
        attrs.delete(param)
        attrs
      end
    end
  end
end
