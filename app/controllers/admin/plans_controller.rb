# frozen_string_literal: true

class Admin
  class PlansController < Admin::BaseController
    before_action :find_plan, only: %i[edit update destroy]
    def index
      @plans = Plan.all
    end

    def new
      @plan = Plan.new
    end

    def create
      @plan = Plan.new(resource_params)
      if @plan.save
        redirect_to admin_plans_path, notice: t('admin.plans.notices.created')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @plan.update(resource_params)
        redirect_to admin_plans_path, notice: t('admin.plans.notices.updated')
      else
        render :edit
      end
    end

    def destroy
      @plan.destroy
      redirect_to admin_plans_path, notice: t('admin.plans.notices.destroyed')
    end

    private

    def find_plan
      @plan = Plan.find(params[:id])
    end

    def resource_params
      params.require(:plan).permit(:price, :name, :code, :description,
                                   :enabled, :special, server_ids: [],
                                                       option_ids: [], option_prices: option_prices_params)
    end

    def option_prices_params
      @plan.present? ? @plan.options.active.map { |o| o.code.to_sym } : []
    end
  end
end
