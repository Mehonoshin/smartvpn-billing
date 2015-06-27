module Proxy
  class ProxyDto
    attr_accessor :host, :port, :country, :protocol, :bandwidth, :ping

    def initialize(host, port, country, protocol=nil, bandwidth=nil, ping=nil)
      @host      = host
      @port      = port
      @country   = country
      @protocol  = protocol
      @bandwidth = bandwidth
      @ping      = ping
    end

    def to_hash
      {
        host: host,
        port: port,
        country: country,
        protocol: protocol,
        bandwidth: bandwidth,
        ping: ping
      }
    end
  end
end
