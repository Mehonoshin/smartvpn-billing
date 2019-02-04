# frozen_string_literal: true

class Option < ActiveRecord::Base
  include AASM

  validates :name, :code, presence: true

  has_and_belongs_to_many :plans
  has_many :user_options
  has_many :users, through: :user_options

  scope :active, -> { where(state: 'active') }

  aasm column: :state do
    state :disabled, initial: true
    state :active

    event :activate do
      transitions from: :disabled, to: :active
    end

    event :disable do
      transitions from: :active, to: :disabled
    end
  end

  def tunable_attributes
    klass = "Options::Attributes::#{code.capitalize}".constantize
    klass.new.attributes
  rescue NameError
    {}
  end

  def default_attributes
    klass = "Options::Attributes::#{code.capitalize}".constantize
    klass.new.default
  rescue NameError
    {}
  end

  def hook(user)
    klass = "Options::Hooks::#{code.capitalize}".constantize
    klass.new(user, self)
  rescue NameError
    nil
  end
end
