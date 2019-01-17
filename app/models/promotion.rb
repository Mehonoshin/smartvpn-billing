class Promotion < ActiveRecord::Base
  attr_accessor :promo_code

  belongs_to :user
  belongs_to :promo

  validates :user_id, uniqueness: { scope: :promo_id }

  scope :with_active_promos, -> { where(promo_id: Promo.active.select(:id)) }

  def apply(amount)
    promo.promoter.apply(promo, amount)
  end
end

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  promo_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

