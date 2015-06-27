class Admin < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable, timeout_in: 7.days
end

# == Schema Information
#
# Table name: admins
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

