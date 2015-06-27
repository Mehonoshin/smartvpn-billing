class GenerateReflinkToOldUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      if user.reflink.nil?
        user.send(:generate_reflink)
        user.save!
      end
    end
  end
end
