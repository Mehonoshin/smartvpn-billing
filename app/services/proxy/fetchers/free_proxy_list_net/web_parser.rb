# frozen_string_literal: true

require 'mechanize'

# Implements parser for http://www.freeproxylists.net/ website
module Proxy
  module Fetchers
    module FreeProxyListNet
      class WebParser < ::Proxy::Fetchers::Base
        URL = 'http://free-proxy-list.net/'
        COLUMNS_IN_PROXY_ROW = 8

        def initialize
          @agent = Mechanize.new
          @proxies = []
        end

        def fetch_proxy_list
          fetch_proxies
        end

        private

        def fetch_proxies
          @agent.get(URL) do |page|
            parse_proxies_from page
          end
          @proxies
        end

        def parse_proxies_from(page)
          table = page.search('#proxylisttable')
          rows = table.search('tbody tr')
          rows.each do |row|
            parse(row)
          end
        end

        def parse(row)
          if row.children.size == COLUMNS_IN_PROXY_ROW
            parser = Proxy::Fetchers::FreeProxyListNet::RowParser.new(row.children)
            @proxies << parser.to_proxy
          end
        end
      end
    end
  end
end
