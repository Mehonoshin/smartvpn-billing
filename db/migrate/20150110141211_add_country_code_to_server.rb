class AddCountryCodeToServer < ActiveRecord::Migration
  def change
    add_column :servers, :country_code, :string, default: 'de'
  end
end
