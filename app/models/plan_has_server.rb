class PlanHasServer < ActiveRecord::Base
  belongs_to :plan
  belongs_to :server
end

# == Schema Information
#
# Table name: plan_has_servers
#
#  id         :integer          not null, primary key
#  server_id  :integer
#  plan_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

