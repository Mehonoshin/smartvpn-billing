# frozen_string_literal: true

require 'spec_helper'

describe Admin::UsersController do
  render_views
  login_admin
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { should be_success }
    it { should render_template :index }
  end

  describe 'GET #payers' do
    before { get :payers }

    it { should be_success }
    it { should render_template :payers }
  end

  describe 'GET #this_month_payers' do
    before { get :this_month_payers }

    it { should be_success }
    it { should render_template :this_month_payers }
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    before { get :show, id: user.id }

    it { should be_success }
    it { should render_template :show }
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    before { get :edit, id: user.id }

    it { should be_success }
    it { should render_template :edit }
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    before { put :update, id: user.id, user: attrs }

    context 'params correct' do
      let(:attrs) { Hash[email: 'new@mail.ru'] }

      it 'redirects to users path' do
        subject.should redirect_to admin_users_path
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
        put :withdraw, id: user.id
      end.to change(Withdrawal, :count).by(1)
    end
  end

  describe 'PUT #prolongate' do
    let!(:user) { create(:user_with_balance) }
    let!(:withdrawal) { create(:withdrawal, user: user) }
    let(:attrs) { Hash[days_number: 10] }

    it 'creates new withdrawal prolongation' do
      expect do
        put :prolongate, id: user.id, withdrawal_prolongation: attrs
      end.to change(WithdrawalProlongation, :count).by(1)
    end

    it 'prolongation is created for last withdrawal' do
      expect do
        put :prolongate, id: user.id, withdrawal_prolongation: attrs
      end.to change(user.withdrawals.last.withdrawal_prolongations, :count).by(1)
    end

    it 'prolongation days number equals form data' do
      put :prolongate, id: user.id, withdrawal_prolongation: attrs
      expect(user.withdrawals.last.withdrawal_prolongations.last.days_number).to eq attrs[:days_number]
    end
  end

  describe 'PUT #payment' do
    let!(:user) { create(:user) }
    let!(:pay_system) { create(:pay_system) }
    let(:attrs) { Hash[amount: 100, pay_system_id: pay_system.id, comment: 'some comment'] }

    it 'creates new payment' do
      expect do
        put :payment, id: user.id, payment: attrs
      end.to change(Payment, :count).by(1)
    end

    context 'after request' do
      before { put :payment, id: user.id, payment: attrs }

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

    it { should be_success }

    it 'contains emails of all users' do
      emails = User.all.map(&:email).join(',')
      expect(response.body).to include emails
    end
  end

  describe 'PUT #enable_test_period' do
    let(:user) { create(:user) }

    it 'calles enable action' do
      put :enable_test_period, id: user.id
      expect(user.reload.test_period.enabled?).to be true
    end

    it 'send email' do
      User.any_instance.stubs(:test_period_started_at).returns(Date.current)
      expect do
        put :enable_test_period, id: user.id
      end.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'redirects to user path' do
      put :enable_test_period, id: user.id
      expect(response).to redirect_to admin_user_path(user)
    end
  end

  describe 'PUT #disable_test_period' do
    let(:user) { create(:user) }

    it 'calles disable action' do
      TestPeriod.any_instance.expects(:disable!)
      put :disable_test_period, id: user.id
    end

    it 'redirects to user path' do
      put :disable_test_period, id: user.id
      expect(response).to redirect_to admin_user_path(user)
    end
  end

  describe 'PUT #force_disconnect' do
    let(:user) { create(:user) }

    it 'calls disconnector' do
      ForcedDisconnect.any_instance.expects(:invoke)
      put :force_disconnect, id: user.id
    end

    it 'redirects to user path' do
      put :force_disconnect, id: user.id
      expect(response).to redirect_to admin_user_path(user)
    end
  end
end
