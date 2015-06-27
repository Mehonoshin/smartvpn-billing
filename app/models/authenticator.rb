class Authenticator
  def initialize(login, password, hostname)
    @login, @password, @hostname = login, password, hostname
    @server = Server.find_by(hostname: hostname)
    @user = find_user
  end

  def valid_credentials?
    user_active? && valid_password? && not_connected_yet? && vpn_enabled? && server_belongs_to_users_plan?
  end

  private

  def find_user
    User.find_by(vpn_login: @login) || User.find_by(email: @login)
  end

  def user_active?
    @user.active?
  end

  def vpn_enabled?
    @user.service_enabled? || test_period_active?
  end

  def test_period_active?
    @user.test_period.enabled? && (Date.current <= @user.test_period.test_period_until)
  end

  def valid_password?
    vpn_credentials_valid? || billing_credentials_valid?
  end

  def billing_credentials_valid?
    @user.valid_password?(@password)
  end

  def vpn_credentials_valid?
    @user.vpn_password == @password
  end

  def not_connected_yet?
    !@user.connected?
  end

  def server_belongs_to_users_plan?
    @user.plan.servers.map(&:hostname).include?(@hostname)
  end
end
