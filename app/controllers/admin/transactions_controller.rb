# frozen_string_literal: true

class Admin::TransactionsController < Admin::BaseController
  def index
    @transactions = transactions.page(params[:page])
  end

  def payments
    @payments = Payment.accepted.page params[:page]
  end

  def withdrawals
    @withdrawals = Withdrawal.page params[:page]
  end

  private

  def transactions
    Kaminari.paginate_array(
      TransactionDecorator.decorate_collection(
        Transaction.all
      )
    )
  end
end
