# frozen_string_literal: true

class Admin
  class OptionsController < Admin::BaseController
    before_action :find_option, only: %i[edit update]
    def index
      @options = Admin::OptionsDecorator.decorate_collection(Option.all)
    end

    def new
      @option = Option.new
    end

    def create
      @option = Option.new(resource_params)
      if @option.save
        redirect_to admin_options_path, notice: t('admin.options.notices.created')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @option.update(resource_params)
        redirect_to admin_options_path, notice: t('admin.options.notices.updated')
      else
        render :edit
      end
    end

    private

    def find_option
      @option = Option.find(params[:id])
    end

    def resource_params
      params.require(:option).permit(:name, :code, :state, plan_ids: [])
    end
  end
end
