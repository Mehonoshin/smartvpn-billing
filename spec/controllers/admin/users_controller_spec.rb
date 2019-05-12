# frozen_string_literal: true

require 'spec_helper'

describe Admin::UsersController do
  render_views
  login_admin
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :index }
  end

  describe 'GET #payers' do
    before { get :payers }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :payers }
  end

  describe 'GET #this_month_payers' do
    before { get :this_month_payers }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :this_month_payers }
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    before { get :show, params: { id: user.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :show }
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }

    before { get :edit, params: { id: user.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :edit }
  end

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to be_successful }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:plan) { create(:plan) }
    let!(:operation) { double('Ops::Admin::User::Create') }

    before { allow(Ops::Admin::User::Create).to receive(:new).with(params: params).and_return(operation) }

    context 'params correct' do
      let(:params) do
        {
          email: 'user@gmail.com',
          password: '123456',
          password_confirmation: '123456',
          plan_id: plan.id.to_s
        }.as_json
      end

      it 'run operation' do
        expect(operation).to receive(:call).and_return(success: true, user: user)
        post :create, params: { user: params }
      end

      it 'redirects to users path' do
        allow(operation).to receive(:call).and_return(success: true, user: user)
        post :create, params: { user: params }
        expect(subject).to redirect_to admin_users_path
      end
    end

    context 'params invalid' do
      let(:params) do
        {
          email: 'user@gmail.com',
          password: '123456',
          password_confirmation: '12345678',
          plan_id: plan.id.to_s
        }.as_json
      end

      it 'run operation' do
        expect(operation).to receive(:call).and_return(success: false, user: user)
        post :create, params: { user: params }
      end

      it 'redirects to users path' do
        allow(operation).to receive(:call).and_return(success: false, user: user)
        post :create, params: { user: params }
        expect(subject).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    before { put :update, params: { id: user.id, user: attrs } }

    context 'params correct' do
      let(:attrs) { Hash[email: 'new@mail.ru'] }

      it 'redirects to users path' do
        expect(subject).to redirect_to admin_users_path
      end
    end

    context 'params invalid' do
      let(:attrs) { Hash[plan_id: nil] }

      it 'renders edit form' do
        expect(subject).to render_template :edit
      end
    end
  end

  describe 'PUT #withdraw' do
    let(:user) { create(:user_with_balance) }

    it 'creates new withdrawal' do
      expect do
        put :withdraw, params: { id: user.id }
      end.to change(Withdrawal, :count).by(1)
    end
  end

  describe 'PUT #prolongate' do
    let!(:user) { create(:user_with_balance) }
    let!(:withdrawal) { create(:withdrawal, user: user) }
    let(:attrs) { Hash[days_number: 10] }

    it 'creates new withdrawal prolongation' do
      expect do
        put :prolongate, params: { id: user.id, withdrawal_prolongation: attrs }
      end.to change(WithdrawalProlongation, :count).by(1)
    end

    it 'prolongation is created for last withdrawal' do
      expect do
        put :prolongate, params: { id: user.id, withdrawal_prolongation: attrs }
      end.to change(user.withdrawals.last.withdrawal_prolongations, :count).by(1)
    end

    it 'prolongation days number equals form data' do
      put :prolongate, params: { id: user.id, withdrawal_prolongation: attrs }
      expect(user.withdrawals.last.withdrawal_prolongations.last.days_number).to eq attrs[:days_number]
    end
  end

  describe 'PUT #payment' do
    let!(:user) { create(:user) }
    let!(:pay_system) { create(:pay_system) }
    let(:attrs) { Hash[amount: 100, pay_system_id: pay_system.id, comment: 'some comment'] }

    it 'creates new payment' do
      expect do
        put :payment, params: { id: user.id, payment: attrs }
      end.to change(Payment, :count).by(1)
    end

    context 'after request' do
      before { put :payment, params: { id: user.id, payment: attrs } }

      it 'payment is accepted' do
        expect(Payment.last.accepted?).to be true
      end

      it 'payment has comment from attrs' do
        expect(Payment.last.comment).to eq attrs[:comment]
      end

      it 'payment is marked as manual' do
        expect(Payment.last.manual_payment).to be true
      end
    end
  end

  describe 'GET #emails_export' do
    before do
      create_list(:user, 2)
      get :emails_export
    end

    it { is_expected.to be_successful }

    it 'contains emails of all users' do
      emails = User.all.map(&:email).join(',')
      expect(response.body).to include emails
    end
  end

  describe 'PUT #enable_test_period' do
    let(:user) { create(:user) }

    it 'calles enable action' do
      put :enable_test_period, params: { id: user.id }
      expect(user.reload.test_period.enabled?).to be true
    end

    it 'send email' do
      allow_any_instance_of(User).to receive(:test_period_started_at).and_return(Date.current)
      expect do
        put :enable_test_period, params: { id: user.id }
      end.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'redirects to user path' do
      put :enable_test_period, params: { id: user.id }
      expect(response).to redirect_to admin_user_path(user)
    end
  end

  describe 'PUT #disable_test_period' do
    let(:user) { create(:user) }

    it 'calles disable action' do
      allow_any_instance_of(TestPeriod).to receive(:disable!)
      put :disable_test_period, params: { id: user.id }
    end

    it 'redirects to user path' do
      put :disable_test_period, params: { id: user.id }
      expect(response).to redirect_to admin_user_path(user)
    end
  end

  describe 'PUT #force_disconnect' do
    let(:user) { create(:user) }

    it 'calls disconnector' do
      allow_any_instance_of(ForcedDisconnect).to receive(:invoke)
      put :force_disconnect, params: { id: user.id }
    end

    it 'redirects to user path' do
      put :force_disconnect, params: { id: user.id }
      expect(response).to redirect_to admin_user_path(user)
    end
  end
end
