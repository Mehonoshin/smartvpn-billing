# frozen_string_literal: true

class Admin
  class PromosController < Admin::BaseController
    before_action :find_promo, only: %i[edit update create]

    def index
      @promos = Promo.all.page(params[:page]).decorate
    end

    def new
      @promo = Promo.new
    end

    def create
      @promo = Promo.new(resource_params)
      if @promo.save
        redirect_to edit_admin_promo_path(@promo), notice: t('admin.promos.notices.created')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @promo.update(resource_params)
        redirect_to edit_admin_promo_path(@promo), notice: t('admin.promos.notices.updated')
      else
        render :edit
      end
    end

    private

    def find_promo
      @promo = Promo.find(params[:id]) if params[:id]
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
end
