class Connect < Connection
end

# == Schema Information
#
# Table name: connections
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  server_id   :integer
#  traffic_in  :float
#  traffic_out :float
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

