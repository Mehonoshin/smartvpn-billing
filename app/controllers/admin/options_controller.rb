# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  def index
    @options = Admin::OptionsDecorator.decorate_collection(Option.all)
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(resource_params)
    if @option.save
      redirect_to admin_options_path, notice: 'Услуга успешно добавлена'
    else
      render :new
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update(resource_params)
      redirect_to admin_options_path, notice: 'Услуга успешно обновлена'
    else
      render :edit
    end
  end

  private

  def resource_params
    params.require(:option).permit(:name, :code, :state, plan_ids: [])
  end
end
