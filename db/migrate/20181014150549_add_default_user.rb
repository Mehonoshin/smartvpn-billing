class AddDefaultUser < ActiveRecord::Migration[5.1]
  def change
    admin = Admin.find_by(email: 'admin@smartvpn.biz')
    return if admin

    Admin.create!(email: 'admin@smartvpn.biz', password: 'password')
  end
end
