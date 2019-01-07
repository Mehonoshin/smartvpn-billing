# frozen_string_literal: true

class Promo < ActiveRecord::Base
  TYPES = %w[withdrawal].freeze
  self.inheritance_column = 'sti_type'

  validates :name, :type, :promoter_type, presence: true

  scope :withdrawal, -> { where(type: 'withdrawal') }
  scope :active, lambda {
                   where("state='active' AND ? BETWEEN date_from AND date_to", Date.current)
                 }

  state_machine :state, initial: :pending do
    event :start do
      transition pending: :active
    end

    event :stop do
      transition active: :pending
    end
  end

  def promoter
    PromotersRepository.find_by_type(promoter_type)
  end
end

# == Schema Information
#
# Table name: promos
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  type          :string(255)
#  date_from     :date
#  date_to       :date
#  promoter_type :string(255)
#  promo_code    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  attrs         :hstore           default({})
#  state         :string(255)
#
