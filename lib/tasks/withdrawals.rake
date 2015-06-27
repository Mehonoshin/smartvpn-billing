namespace :smartvpn do
  namespace :withdrawals do

    desc "Withdraw funds from users"
    task :run => :environment do
      Withdrawer.mass_withdrawal
      UnpaidUsersNotificator.new.notify_all
    end

  end
end
