# frozen_string_literal: true

class Proxy::Connect < ActiveRecord::Base
  include AASM

  belongs_to :proxy, class_name: 'Proxy::Node', foreign_key: 'proxy_id'
  belongs_to :user

  aasm column: :state do
    state :active, initial: true
    state :inactive

    event :remove do
      transitions from: :active, to: :inactive
    end
  end
end
