class Admin::UsersSerializer
  attr_accessor :collection, :format

  def initialize(collection, format)
    @collection = collection
    @format     = format
  end

  def emails
    if csv?
      collection.map(&:email).join(',')
    end
  end

  private

  def csv?
    format == :csv
  end
end
