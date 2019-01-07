# frozen_string_literal: true

class Connector
  attr_reader :user, :server

  def self.connected?(user)
    (has_previous_connects?(user) && connected_now?(user)) || first_time_connected?(user)
  end

  def self.first_time_connected?(user)
    user.disconnects.last.nil? && user.connects.last
  end

  def self.has_previous_connects?(user)
    user.connects.last && user.disconnects.last
  end

  def self.connected_now?(user)
    user.connects.last.created_at > user.disconnects.last.created_at
  end

  def initialize(opts)
    @options = opts
    @user = find_user
    @server = Server.find_by(hostname: opts[:hostname])
    @action = opts[:action]
    @traffic_in = opts[:traffic_in]
    @traffic_out = opts[:traffic_out]
  end

  def invoke
    if connect?
      connect!
    else
      disconnect!
    end
  end

  private

  def find_user
    User.find_by(vpn_login: @options[:login]) || User.find_by(email: @options[:login])
  end

  def connect?
    @action == 'connect'
  end

  # TODO:
  # refactor this, extract invoke_hook(:hook_name) method
  def connect!
    payload = {}
    user.options.active.each do |option|
      hook = option.hook(@user)
      payload[option.code] = hook ? hook.connect : {}
    end
    user.connects.create!(server_id: server.id, option_attributes: payload)
  end

  def disconnect!
    payload = {}
    user.options.active.each do |option|
      hook = option.hook(@user)
      payload[option.code] = hook ? hook.disconnect : {}
    end
    user.disconnects.create!(server_id: server.id, option_attributes: payload, traffic_in: @traffic_in, traffic_out: @traffic_out)
  end
end
