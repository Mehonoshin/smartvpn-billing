# frozen_string_literal: true

class Admin::UsersSerializer
  attr_accessor :collection, :format

  def initialize(collection, format)
    @collection = collection
    @format     = format
  end

  def emails
    collection.map(&:email).join(',') if csv?
  end

  private

  def csv?
    format == :csv
  end
end
