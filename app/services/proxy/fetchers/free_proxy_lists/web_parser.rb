# frozen_string_literal: true

require 'mechanize'

# Implements parser for http://www.freeproxylists.net/ website
module Proxy
  module Fetchers
    module FreeProxyLists
      class WebParser < ::Proxy::Fetchers::Base
        URL = 'http://www.freeproxylists.net/?c=&pt=&pr=HTTP&a%5B%5D=0&a%5B%5D=1&a%5B%5D=2&u=0'
        COLUMNS_IN_PROXY_ROW = 10

        def initialize
          @agent = Mechanize.new
          @proxies = []
        end

        def fetch_proxy_list
          fetch_proxies
        end

        private

        def fetch_proxies
          @agent.get('http://www.freeproxylists.net/') do |page|
            parse_proxies_from page
          end
          @proxies
        end

        def parse_proxies_from(page)
          table = page.search('.DataGrid')
          rows = table.search('tr.Odd, tr.Even')
          rows.each do |row|
            parse(row, @proxies)
          end
        end

        def parse(row, _proxies)
          if row.children.size == COLUMNS_IN_PROXY_ROW
            parser = Proxy::Fetchers::FreeProxyLists::RowParser.new(row.children)
            @proxies << parser.to_proxy
          end
        end
      end
    end
  end
end
