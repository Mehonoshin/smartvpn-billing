# frozen_string_literal: true

class AddDefaultUser < ActiveRecord::Migration
  def change
    admin = Admin.find_by(email: 'admin@smartvpn.biz')
    return if admin

    Admin.create!(email: 'admin@smartvpn.biz', password: 'password')
  end
end
