# frozen_string_literal: true

class Api::ConnectionSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :options, :common_name, :option_attributes

  def options
    option_attributes.keys
  end

  def option_attributes
    object.option_attributes || {}
  end

  def common_name
    object.user.vpn_login
  end
end
