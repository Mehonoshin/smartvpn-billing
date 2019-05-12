# frozen_string_literal: true

class Admin
  class UsersController < Admin::BaseController
    before_action :find_user, only: %i[show edit update withdraw
                                       prolongate payment enable_test_period
                                       disable_test_period force_disconnect]
    decorates_assigned :user

    def index
      @users = users.page params[:page]
    end

    def payers
      @users = users.payers.page params[:page]
    end

    def this_month_payers
      @users = users.this_month_payers.page params[:page]
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      result = ::Ops::Admin::User::Create.new(params: resource_params).call
      if result[:success]
        redirect_to admin_users_path, notice: t('admin.users.notices.created')
      else
        @user = result[:user]
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(resource_params)
        redirect_to admin_users_path, notice: t('admin.users.notices.updated')
      else
        render :edit
      end
    end

    def withdraw
      Withdrawer.single_withdraw(@user)
      redirect_to admin_users_path, notice: t('admin.users.notices.write_off')
    end

    def prolongate
      @user.withdrawals.last.withdrawal_prolongations.create!(days_number: days_number_prolongate)
      redirect_to admin_user_path(@user), notice: t('admin.users.notices.prolongated')
    end

    def payment
      payment = @user.payments.create!(payment_params)
      payment.accept!
      redirect_to admin_user_path(@user), notice: t('admin.users.notices.payment_created')
    end

    def emails_export
      users = User.ransack(search_params).result
      render plain: Admin::UsersSerializer.new(users, :csv).emails
    end

    def enable_test_period
      @user.test_period.enable!
      UserMailer.test_period_enabled(@user).deliver_now
      redirect_to admin_user_path(@user), notice: t('admin.users.notices.test_period_enabled')
    end

    def disable_test_period
      @user.test_period.disable!
      redirect_to admin_user_path(@user), notice: t('admin.users.notices.test_period_disabled')
    end

    def force_disconnect
      ForcedDisconnect.new(@user).invoke
      redirect_to admin_user_path(@user), notice: t('admin.users.notices.disconnected')
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def users
      search.result.order('id DESC')
    end

    def search
      User.ransack(params[:q])
    end
    helper_method :search

    def search_params
      if params[:q]
        params[:q].permit(:email_cont, :plan_id_eq, :never_paid_eq)
      else
        {}
      end
    end
    helper_method :search_params

    def payment_params
      params.require(:payment).permit(:amount, :pay_system_id, :comment).merge!(manual_payment: true)
    end

    def resource_params
      params
        .require(:user)
        .permit(:email, :plan_id, :state, :balance, :period_length, :password, :password_confirmation)
    end

    def days_number_prolongate
      params[:withdrawal_prolongation][:days_number]
    end
  end
end
