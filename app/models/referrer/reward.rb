class Referrer::Reward < ActiveRecord::Base
  validates :referrer_id, :operation_id, :amount, presence: true
  belongs_to :operation, foreign_key: 'operation_id', class_name: 'Withdrawal'

end
