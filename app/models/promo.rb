# frozen_string_literal: true

class Promo < ActiveRecord::Base
  include AASM

  TYPES = [withdrawal]
  self.inheritance_column = 'sti_type'

  validates :name, :type, :promoter_type, presence: true

  scope :withdrawal, -> { where(type: 'withdrawal') }
  scope :active, lambda {
    where("state='active' AND ? BETWEEN date_from AND date_to", Date.current)
  }

  aasm column: :state do
    state :pending, initial: true
    state :active

    event :start do
      transitions from: :pending, to: :active
    end

    event :stop do
      transitions from: :active, to: :pending
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
