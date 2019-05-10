class CreateOptionsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :options_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :option
    end
  end
end
