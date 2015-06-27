class Admin::PlansController < Admin::BaseController
  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(resource_params)
    if @plan.save
      redirect_to admin_plans_path, notice: "Тариф успешно добавлен"
    else
      render :new
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(resource_params)
      redirect_to admin_plans_path, notice: "Тариф успешно обновлен"
    else
      render :edit
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.delete
    redirect_to admin_plans_path, notice: "Тариф удален"
  end

  private

  def resource_params
    params.require(:plan).permit(:price, :name, :code, :description,
                                 :enabled, :special, server_ids: [],
                                 option_ids: [], option_prices: option_prices_params)
  end

  def option_prices_params
    @plan.present? ? @plan.options.active.map { |o| o.code.to_sym } : []
  end
end

