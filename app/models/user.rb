class User < ActiveRecord::Base
  include LastDaysFilterable

  BILLING_INTERVAL    = 30
  DEFAULT_TEST_PERIOD = 3

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  attr_accessor :accept_agreement

  belongs_to :plan
  belongs_to :referrer, class_name: 'User'
  has_many :referrals, foreign_key: 'referrer_id', class_name: 'User'

  has_many :payments
  has_many :withdrawals

  has_many :connects
  has_many :disconnects

  has_many :promotions

  # TODO:
  # strange pool of relations.
  # needs to be refactored
  has_many :user_options
  has_many :enabled_user_options, -> { enabled }, foreign_key: 'user_id', class_name: 'UserOption'
  has_many :options, ->{ active }, through: :enabled_user_options
  has_many :subscribed_options, ->{ active }, through: :user_options, class_name: 'Option'

  validates :plan_id, presence: true
  validates :accept_agreement, acceptance: true, on: :create
  validate :selected_plan_is_regular, on: :create

  before_create :generate_vpn_credentials, :generate_reflink
  after_create :add_to_newsletter

  scope :active_referrers, -> { joins('INNER JOIN users AS referrals ON referrals.referrer_id=users.id').distinct }
  scope :payers, ->{ where("id IN (SELECT user_id FROM payments)") }
  scope :this_month_payers, ->{ where("id IN (SELECT user_id FROM payments WHERE created_at >= ? AND created_at <= ?)", Date.current.beginning_of_month, Date.current.end_of_month) }
  scope :non_paid_users, ->{ where("
      id NOT IN (
          SELECT user_id 
          FROM withdrawals 
          WHERE (DATE(?) - DATE(withdrawals.created_at)) < ?)
      ", Time.current, BILLING_INTERVAL).order("id ASC")
  }
  scope :never_paid, ->{ where('id NOT IN (SELECT user_id FROM withdrawals)') }

  ransacker :never_paid, callable: NeverPaidUsersRansacker

  state_machine :state, :initial => :active do
    event :disable do
      transition :active => :disabled
    end

    event :activate do
      transition :disabled => :active
    end
  end

  public

  def to_s
    email
  end

  def referrer_account
    Referrer::Account.new(id)
  end

  def test_period
    TestPeriod.new(self)
  end

  def connected?
    Connector.connected? self
  end

  def paid?
    last_withdrawal && (((Time.current - last_withdrawal_date).to_i / 1.day) < current_billing_interval_length)
  end

  def current_billing_interval_length
    BILLING_INTERVAL + interval_prolongation
  end

  def last_connect
    connects.last
  end

  def last_connect_date
    last_connect.try :created_at
  end

  def last_withdrawal
    withdrawals.last
  end

  def last_withdrawal_date
    last_withdrawal.try :created_at
  end

  def next_withdrawal_date
    last_withdrawal_date + current_billing_interval_length.days if last_withdrawal
  end

  def increase_balance(amount)
    self.class.where(id: id).update_all(["balance = balance + ?", amount])
    IncreaseBalanceMailWorker.perform_async(amount, id)
  end

  def decrease_balance(amount)
    self.class.where(id: id).update_all(["balance = balance - ?", amount])
    DecreaseBalanceMailWorker.perform_async(amount, id)
  end

  def service_enabled?
    paid? || false
  end

  def total_amount
    payments.accepted.sum(:usd_amount)
  end

  private

    def interval_prolongation
      last_withdrawal ? last_withdrawal.prolongation_days : 0
    end

    def selected_plan_is_regular
      unless plan && plan.regular?
        errors.add(:plan_id, I18n.t('activerecord.validations.user.regular_plan'))
      end
    end

    def generate_reflink
      self.reflink = Signer.hashify_string(email)
    end

    def generate_vpn_credentials
      self.vpn_login = Signer.hashify_string(email)
      self.vpn_password = RandomString.generate(12)
    end

    def add_to_newsletter
      AddUserToNewsletterWorker.perform_async(email, :all)
    end
end

# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(255)      default(""), not null
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
#  unconfirmed_email        :string(255)
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

