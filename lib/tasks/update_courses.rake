namespace :smartvpn do
  namespace :courses do

    desc "Update courses"
    task :update => :environment do
      Currencies::Course.update_courses
    end

  end
end
