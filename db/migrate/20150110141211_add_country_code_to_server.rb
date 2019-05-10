class AddCountryCodeToServer < ActiveRecord::Migration[5.1]
  def change
    add_column :servers, :country_code, :string, default: 'de'
  end
end
