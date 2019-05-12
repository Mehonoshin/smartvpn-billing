# frozen_string_literal: true

require 'spec_helper'

describe Billing::PaymentsController do
  context 'when not authorized' do
    it 'does not respond' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when regular user' do
    let(:pay_system) { create(:pay_system) }

    login_user

    it 'displays pay systems list' do
      get :index
      expect(response).to render_template :index
    end

    it 'displays new payment form' do
      get :new, params: { code: pay_system.code }
      expect(response).to render_template :new
    end

    it 'redirects to merchant form page on payment create' do
      post :create, params: { payment: attributes_for(:payment).merge!(pay_system_id: pay_system.id) }
      expect(response).to redirect_to merchant_billing_payment_path(Payment.last)
    end

    context 'when payment is already accepted' do
      before do
        @payment = create(:payment, user: @user)
        @payment.accept!
      end

      it 'redirects to pay systems list' do
        get :merchant, params: { id: @payment.id }
        expect(response).to redirect_to billing_payments_path
      end
    end
  end
end
