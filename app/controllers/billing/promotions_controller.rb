class Billing::PromotionsController < Billing::BaseController
  def create
    @promo = Promo.active.find_by(promo_code: params[:promotion][:promo_code])
    if @promo
      create_promotion
    else
      redirect_to edit_user_registration_path, alert: t('billing.promotions.notices.no_promos_found')
    end
  end

  private

  def create_promotion
    promotion = current_user.promotions.new(promo_id: @promo.id)
    if promotion.save
      redirect_to edit_user_registration_path, notice: t('billing.promotions.notices.promotion_activated')
    else
      redirect_to edit_user_registration_path, alert: t('billing.promotions.notices.promotion_already_activated')
    end
  end
end
