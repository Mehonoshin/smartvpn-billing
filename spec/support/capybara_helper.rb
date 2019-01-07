def visit_sign_in_page
  visit('/users/sign_in')
end

def sign_in(user = nil, password = nil)
  password = 'password' unless password
  @user = user ? user : create(:user, password: password)

  visit_sign_in_page
  within('form#new_user') do
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: password
  end
  click_button I18n.t('main.auth.sign_in')
end

def last_email
  ActionMailer::Base.deliveries.last
end

def extract_token_from_email(token_name, current_email)
  mail_body = current_email.body.to_s
  mail_body[/#{token_name.to_s}=([^"]+)/, 1]
end

def sign_in_admin
  admin = create(:admin, email: 'admin@smartvpn.biz', password: '1234567')
  visit('/admins/sign_in')
  within('form#new_admin') do
    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: '1234567'
  end
  click_button I18n.t('admins.sessions.new.sign_in')
end
