# frozen_string_literal: true

class Option < ActiveRecord::Base
  validates :name, :code, presence: true

  has_and_belongs_to_many :plans
  has_many :user_options
  has_many :users, through: :user_options

  scope :active, -> { where(state: 'active') }

  state_machine :state, initial: :disabled do
    event :activate do
      transition disabled: :active
    end

    event :disable do
      transition active: :disabled
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
