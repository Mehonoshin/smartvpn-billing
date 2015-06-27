module Options
  module Attributes
    class Proxy
      def initialize
        @countries = ::Proxy::Node.select(:country).distinct.map(&:country)
      end

      def attributes
        {
          country: { type: :select, value: @countries }
        }
      end

      def default
        {
          country: @countries.first
        }
      end
    end
  end
end
