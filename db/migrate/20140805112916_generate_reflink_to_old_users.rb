class GenerateReflinkToOldUsers < ActiveRecord::Migration[5.1]
  def change
    User.all.each do |user|
      if user.reflink.nil?
        user.send(:generate_reflink)
        user.save!
      end
    end
  end
end
