# frozen_string_literal: true

class Transaction
  attr_accessor :object, :id
  delegate :created_at, to: :object

  class << self
    def all
      cast_collection_to_transactions(Payment.accepted, Withdrawal.all)
    end

    def user_transactions(user)
      payments = user.payments.accepted
      withdrawals = user.withdrawals
      cast_collection_to_transactions(payments, withdrawals)
    end

    def cast_collection_to_transactions(payments, withdrawals)
      (payments.to_a + withdrawals.to_a)
        .sort_by(&:created_at)
        .each_with_index
        .map { |t, id| Transaction.new(id + 1, t) }
        .reverse!
    end
  end

  def initialize(id, object)
    @object = object
    @id = id
  end

  def amount
    # If this is a Deposit, we will get usd_amount
    # otherwise, it is a write-off, and then take amount
    object.try(:usd_amount) || object.amount
  end
end
