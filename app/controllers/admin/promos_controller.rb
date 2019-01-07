# frozen_string_literal: true

class Admin::PromosController < Admin::BaseController
  before_action :load_promo, only: %i[new edit update create]

  def index
    @promos = Promo.all.page(params[:page]).decorate
  end

  def new; end

  def create
    if @promo.update(resource_params)
      redirect_to edit_admin_promo_path(@promo), notice: 'Акция успешно создана'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @promo.update(resource_params)
      redirect_to edit_admin_promo_path(@promo), notice: 'Акция успешно обновлена'
    else
      render :edit
    end
  end

  private

  def load_promo
    @promo = Promo.find(params[:id]) if params[:id]
    @promo ||= Promo.new
  end

  def resource_params
    params[:promo].permit(:name, :promo_code, :promoter_type, :type,
                          :state, :date_from, :date_to, attrs: all_promoters_attributes)
  end

  def all_promoters_attributes
    PromotersRepository.all.inject([]) do |attrs, promoter|
      attrs + promoter.attributes
    end
  end
end
