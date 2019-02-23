# frozen_string_literal: true

class OptionAttributeDecorator < Draper::Decorator
  attr_accessor :name, :current_value

  def initialize(name, values, current_value)
    @name = name
    @current_value = current_value
    super(values)
  end

  def render
    h.select_tag name, h.options_for_select(data_for_select, selected: current_value) if object[:type] == :select
  end

  private

  def data_for_select
    object[:value].map { |data| [data, data] }
  end
end
