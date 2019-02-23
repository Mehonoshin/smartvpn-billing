# frozen_string_literal: true

class Proxy::Node < ActiveRecord::Base
  validates :host, :port, :country, presence: true
  has_many :connects, class_name: 'Proxy::Connect', foreign_key: 'proxy_id'
end
