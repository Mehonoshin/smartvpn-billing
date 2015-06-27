module Options
  module Hooks
    class Proxy
      attr_accessor :user, :option

      def initialize(user, option)
        @user, @option = user, option
      end

      def connect
        proxy = ::Proxy::Rater.new(user, option).find_best
        proxy.connects.create!(user: user)
        { host: proxy.host, port: proxy.port }
      end

      def disconnect
        proxy_connect = ::Proxy::Connect.find_by(user_id: user.id)
        proxy = proxy_connect.proxy
        proxy_connect.delete
        { host: proxy.host, port: proxy.port }
      end
    end
  end
end
