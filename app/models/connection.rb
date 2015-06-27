class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :server

  delegate :hostname, to: :server

  def self.active
    ids = ActiveRecord::Base.connection.execute("
      SELECT id
      FROM connections AS c
      WHERE type='Connect'
        AND NOT EXISTS (
          SELECT 1
          FROM connections AS d
          WHERE
            type='Disconnect'
            AND c.user_id=d.user_id
            AND c.created_at < d.created_at
        );
    ").values.flatten
    where(id: ids)
  end
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

