# frozen_string_literal: true

class Server < ActiveRecord::Base
  include AASM

  PROTOCOLS = ["udp", "tcp"]

  has_many :connects
  has_many :disconnects

  has_many :included_plans, class_name: 'PlanHasServer'
  has_many :plans, through: :included_plans

  validates :hostname, :port, :ip_address, :country_code, presence: true
  validates :hostname, uniqueness: true
  validates :protocol, presence: true, inclusion: { in: PROTOCOLS }

  before_create :generate_auth_key

  aasm column: :state do
    state :pending, initial: true
    state :disabled, :active

    event :activate do
      transitions from: :pending, to: :active
    end

    event :disable do
      transitions from: :active, to: :disabled
    end
  end

  def to_s
    hostname
  end

  private

  def generate_auth_key
    self.auth_key = RandomString.generate
  end
end

# == Schema Information
#
# Table name: servers
#
#  id         :integer          not null, primary key
#  hostname   :string(255)
#  ip_address :string(255)
#  auth_key   :string(255)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :string(255)
#
