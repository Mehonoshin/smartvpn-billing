class WithdrawalProlongation < ActiveRecord::Base
  belongs_to :withdrawal

  validates :withdrawal_id, :days_number, presence: true
end
