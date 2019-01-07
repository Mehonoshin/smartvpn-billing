# frozen_string_literal: true

class Admin::ServersController < Admin::BaseController
  before_action :load_resource, only: %i[show edit update destroy generate_config]

  def index
    @servers = Server.all
  end

  def show; end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(resource_params)
    if @server.save
      redirect_to admin_servers_path, notice: 'Сервер успешно добавлен'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @server.update(resource_params)
      redirect_to admin_servers_path, notice: 'Сервер успешно обновлен'
    else
      render :edit
    end
  end

  def destroy
    @server.delete
    redirect_to admin_servers_path, notice: 'Сервер удален'
  end

  def generate_config
    builder = ServerConfigBuilder.new(@server)
    config_file = builder.generate_config
    send_data config_file.to_text, filename: "#{@server.hostname}.ovpn"
  end

  private

  def load_resource
    @server = Server.find(params[:id])
  end

  def resource_params
    params.require(:server).permit(:hostname, :ip_address, :state,
                                   :config, :protocol, :port, :country_code,
                                   plan_ids: [])
  end
end
