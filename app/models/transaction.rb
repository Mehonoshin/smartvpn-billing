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
        .sort_by { |t| t.created_at }
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
    # Если это пополнение - то получим usd_amount
    # иначе это списание, и тогда возьмем amount
    object.try(:usd_amount) || object.amount
  end
end
