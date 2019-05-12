# frozen_string_literal: true

require 'spec_helper'

describe User do
  subject { user }

  let(:user) { build(:user) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to :referrer }
  it { is_expected.to have_many :referrals }

  it { is_expected.to validate_presence_of(:plan_id) }
  it { is_expected.to validate_acceptance_of(:accept_agreement) }

  it { is_expected.to have_many(:connects) }
  it { is_expected.to have_many(:disconnects) }
  it { is_expected.to have_many(:promotions) }
  it { is_expected.to have_many(:options) }
  it { is_expected.to have_many(:user_options) }

  it 'returns only active options' do
    user = create(:user)
    2.times do
      user.options << create(:option)
      user.options << create(:active_option)
    end

    expect(user.options.size).to eq 2
  end

  it_behaves_like 'loads created by last days', :user
end

describe User, 'custom validations' do
  subject { build(:user, plan_id: plan.id) }

  context 'user with regular plan' do
    let(:plan) { create(:plan) }

    it { is_expected.to be_valid }
  end

  context 'user with special plan created' do
    let(:plan) { create(:plan, special: true) }

    it { is_expected.not_to be_valid }
  end

  context 'user changed plan from regular to special' do
    subject { create(:user, plan_id: plan.id) }

    let(:plan) { create(:plan) }
    let(:new_plan) { create(:plan, special: true) }

    it 'allowes user to change plan' do
      subject.plan_id = new_plan.id
      expect(subject).to be_valid
    end
  end
end

describe User, 'public methods' do
  subject { create(:user_with_balance) }

  describe '#test period' do
    it 'returns TestPeriod instance' do
      expect(subject.test_period.class).to eq TestPeriod
    end
  end

  it 'returns email' do
    expect(subject.to_s).to eq subject.email
  end

  describe '#referrer_account' do
    it 'returns account instance' do
      expect(subject.referrer_account.class).to eq Referrer::Account
    end
  end

  describe '#total_amount' do
    before do
      accepted_payment = create(:payment, user: subject)
      create(:payment, user: subject)
      accepted_payment.accept!
    end

    it 'returns total amount of user' do
      expect(subject.total_amount).to eq attributes_for(:payment)[:amount]
    end
  end

  describe User, 'balance increase' do
    before { IncreaseBalanceMailWorker.jobs.clear }

    it 'allowes to increase balance' do
      subject.increase_balance(100)
      expect(subject.reload.balance).to eq 200
    end

    it 'adds email task to queue' do
      expect { subject.increase_balance(100) }.to change(IncreaseBalanceMailWorker.jobs, :size).by(1)
    end

    it 'notifies user by email' do
      expect do
        subject.increase_balance(100)
        IncreaseBalanceMailWorker.drain
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  describe User, 'balance decrease' do
    before { DecreaseBalanceMailWorker.jobs.clear }

    it 'allowes to decrease balance' do
      subject.decrease_balance(100)
      expect(subject.reload.balance).to eq 0
    end

    it 'adds email task to queue' do
      expect { subject.decrease_balance(100) }.to change(DecreaseBalanceMailWorker.jobs, :size).by(1)
    end

    it 'notifies user by email' do
      expect do
        subject.decrease_balance(100)
        DecreaseBalanceMailWorker.drain
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  describe '.last_connect' do
    before do
      create(:connect, user: subject)
    end

    it 'returns last connect' do
      last_connect = create(:connect, user: subject)
      expect(subject.last_connect).to eq last_connect
    end
  end

  describe '.last_connect_date' do
    let!(:connect) { create(:connect, user: subject) }

    it 'returns date of last connect' do
      expect(subject.last_connect_date.to_i).to eq connect.created_at.to_i
    end
  end

  describe '.last_withdrawal_date' do
    let!(:withdrawal) { create(:withdrawal, user: subject) }

    it 'returns date of last withdrawal' do
      expect(subject.last_withdrawal_date.to_i).to eq withdrawal.created_at.to_i
    end
  end

  describe '.service_enabled?' do
    subject { user.service_enabled? }

    let(:user) { create(:user_with_balance) }

    context 'user has paid in current billing interval' do
      before { create(:withdrawal, user: user) }

      it 'service is enabled' do
        expect(subject).to be true
      end
    end

    context "user hasn't paid" do
      it 'service is disabled' do
        expect(subject).to be false
      end
    end
  end

  describe '.paid?' do
    let(:user) { create(:user_with_balance) }

    context 'user is paid' do
      let!(:withdrawal) { create(:withdrawal, user: subject) }

      it 'returns true' do
        expect(subject.paid?).to be true
      end

      context 'user is prolongated' do
        before { create(:withdrawal_prolongation, withdrawal: withdrawal) }

        it 'returns true' do
          expect(subject.paid?).to be true
        end
      end
    end

    context 'user payment expired, but prolongated' do
      let!(:withdrawal) { create(:withdrawal, user: subject, created_at: 2.month.ago) }
      let!(:prolongation) { create(:withdrawal_prolongation, withdrawal: withdrawal, days_number: 100) }

      it 'returns true' do
        expect(subject.paid?).to be true
      end
    end

    context 'user payment expired, prolongation expired too' do
      let!(:withdrawal) { create(:withdrawal, user: subject, created_at: 2.month.ago) }
      let!(:prolongation) { create(:withdrawal_prolongation, withdrawal: withdrawal, days_number: 10) }

      it 'returns false' do
        expect(subject.paid?).to be false
      end
    end

    context 'user is unpaid' do
      it 'returns false' do
        expect(subject.paid?).not_to be true
      end
    end
  end
end

describe User, 'callbacks on create' do
  subject { create(:user) }

  describe 'vpn credentials creation' do
    it 'generates login' do
      expect(subject.vpn_login).not_to be_nil
    end

    it 'generates password' do
      expect(subject.vpn_password).not_to be_nil
    end

    it 'vpn password is 12 digits long' do
      expect(subject.vpn_password.length).to eq 12
    end
  end

  describe 'generate reflink' do
    it 'creates reflink' do
      expect(subject.reflink).not_to be_nil
    end
  end

  describe 'newsletter subscription' do
    it 'adds to newsletter' do
      expect do
        create(:user)
      end.to change(AddUserToNewsletterWorker.jobs, :size).by(1)
    end
  end
end

describe User, 'scopes' do
  describe 'by payments' do
    let!(:paid_user) { create(:user) }
    let!(:earliar_paid_user) { create(:user) }
    let!(:not_paid_user) { create(:user) }

    before do
      create(:payment, user: paid_user)
      old_payment = create(:payment, user: earliar_paid_user)
      old_payment.update(created_at: 2.month.ago)
    end

    describe '.payers' do
      subject(:payers) { described_class.payers }

      it 'returns this month payers' do
        expect(payers).to include paid_user
      end

      it 'returns old payers' do
        expect(payers).to include earliar_paid_user
      end
    end

    describe '.this_month_payers' do
      subject(:payers) { described_class.this_month_payers }

      it 'returns obly who paid at this month' do
        expect(payers).to include paid_user
        expect(payers).not_to include earliar_paid_user
      end
    end
  end

  describe '#non_paid_clients' do
    before do
      t = Time.local(2014, 9, 15, 12, 0, 0)
      Timecop.travel(t)
    end

    context 'time sensetive scope' do
      let!(:paid_client) { create :user_with_balance, email: 'paid@mail.ru' }
      let!(:new_client) { create :user_with_balance, email: 'new@mail.ru' }
      let!(:non_paid_client) { create :user_with_balance, email: 'not@mail.ru' }
      let!(:non_paid_client2) { create :user_with_balance, email: 'not2@mail.ru' }

      let(:result) { described_class.non_paid_users }

      before do
        create(:withdrawal, user: paid_client, created_at: 2.day.ago)

        old_withdrawal = create(:withdrawal, user: non_paid_client)
        old_withdrawal.update(created_at: 2.month.ago)

        old_withdrawal2 = create(:withdrawal, user: non_paid_client2)
        old_withdrawal2.update(created_at: 5.month.ago)
      end

      it 'returns 3 clients' do
        expect(result.size).to eq 3
      end

      it 'sorts by client registration' do
        expect(result).to eq [new_client, non_paid_client, non_paid_client2]
      end

      it 'contains new client' do
        expect(result).to include new_client
      end

      it 'contains non paid client' do
        expect(result).to include non_paid_client
      end

      it 'contains non paid client2' do
        expect(result).to include non_paid_client2
      end
    end
  end

  describe '.never_paid' do
    let!(:paid_client) { create :user_with_balance, email: 'paid@mail.ru' }
    let!(:new_client) { create :user_with_balance, email: 'new@mail.ru' }
    let!(:paid_long_ago_client) { create :user_with_balance, email: 'not@mail.ru' }

    let(:result) { described_class.never_paid }

    before do
      create(:withdrawal, user: paid_client, created_at: 2.day.ago)

      old_withdrawal = create(:withdrawal, user: paid_long_ago_client)
      old_withdrawal.update(created_at: 2.month.ago)
    end

    it 'returns 1 client' do
      expect(result.size).to eq 1
    end

    it 'contains new client' do
      expect(result).to include new_client
    end

    it 'does not contain long ago client' do
      expect(result).not_to include paid_long_ago_client
    end

    it 'does not contain paid client' do
      expect(result).not_to include paid_client
    end
  end

  describe '.active_referrers' do
    subject { described_class.active_referrers }

    let!(:referrer1) { create(:user) }
    let!(:referrer2) { create(:user) }
    let!(:referrer3) { create(:user) }

    before do
      create_list(:user, 2, referrer: referrer1)
      create_list(:user, 1, referrer: referrer2)
    end

    it 'returns referrers with referrals' do
      expect(subject.map(&:email)).to include referrer1.email
      expect(subject.map(&:email)).to include referrer2.email
    end

    it 'returns two users' do
      expect(subject.size).to eq 2
    end

    it 'does not return referrer without referrals' do
      expect(subject.map(&:email)).not_to include referrer3.email
    end
  end
end

describe User, 'states' do
  subject { build(:user) }

  context 'new' do
    it 'has active status' do
      expect(subject.active?).to be true
    end
  end

  context '.disable! called' do
    it 'changes state to disabled' do
      expect do
        subject.disable!
      end.to change(subject, :state).to('disabled')
    end
  end

  context '.activate! called' do
    before { subject.disable! }

    it 'changes state to active' do
      expect do
        subject.activate!
      end.to change(subject, :state).to('active')
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(128)      default(""), not null
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  confirmation_token       :string(255)
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  failed_attempts          :integer          default(0)
#  unlock_token             :string(255)
#  locked_at                :datetime
#  created_at               :datetime
#  updated_at               :datetime
#  balance                  :decimal(, )      default(0.0)
#  plan_id                  :integer
#  vpn_login                :string(255)
#  vpn_password             :string(255)
#  state                    :string(255)
#  can_not_withdraw_counter :integer          default(0)
#
