class Billing::HomeController < Billing::BaseController
  def index
    @transactions = transactions.page(params[:page])
    @connected = current_user.connected?
    @connection_server = current_user.connects.last.try(:server)
  end

  private

  def transactions
    Kaminari.paginate_array(
      TransactionDecorator.decorate_collection(
        Transaction.user_transactions(
          current_user
        )
      )
    )
  end
end
