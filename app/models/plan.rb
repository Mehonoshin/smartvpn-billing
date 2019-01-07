# frozen_string_literal: true

class Plan < ActiveRecord::Base
  validates :price, :name, :code, :description, presence: true
  has_many :users

  has_many :included_servers, class_name: 'PlanHasServer'
  has_many :servers, through: :included_servers
  has_and_belongs_to_many :options

  scope :regular, -> { where('special IS NOT true') }
  scope :enabled, -> { where(enabled: true) }

  def regular?
    !special
  end

  def to_s
    name
  end

  def option_price(option_code)
    option_prices[option_code].to_i
  end
end

# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  price       :decimal(, )
#  description :text
#  code        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  special     :boolean          default(FALSE)
#  enabled     :boolean          default(FALSE)
#
