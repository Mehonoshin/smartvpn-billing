# frozen_string_literal: true

class Admin::ConnectionsController < Admin::BaseController
  def index
    @connections = connections.order('id DESC').page params[:page]
  end

  def active
    @connections = connections.active.order('id DESC').page params[:page]
  end

  def show
    @connection = Connection.find(params[:id])
  end

  private

  def connections
    search.result
  end

  def search
    Connection.ransack(params[:q])
  end
  helper_method :search
end
