# frozen_string_literal: true

class Admin::PaySystemsController < Admin::BaseController
  before_action :load_resource, only: %i[show edit update destroy]

  def index
    @pay_systems = PaySystem.all.decorate
  end

  def show; end

  def new
    @pay_system = PaySystem.new
  end

  def create
    @pay_system = PaySystem.new(resource_params)
    if @pay_system.save
      redirect_to admin_pay_systems_path, notice: 'Платежная система успешно добавлена'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @pay_system.update(resource_params)
      redirect_to admin_pay_systems_path, notice: 'Платежная система успешно обновлена'
    else
      render :edit
    end
  end

  private

  def load_resource
    @pay_system = PaySystem.find(params[:id])
  end

  def resource_params
    params.require(:pay_system).permit(:name, :code, :description, :state, :currency)
  end
end
