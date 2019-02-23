# frozen_string_literal: true

class BaseRansacker
  attr_reader :table

  # @param [Arel::Table] table
  def initialize(table)
    @table = table
  end

  def self.call(parent)
    new(parent.table)
  end
end
