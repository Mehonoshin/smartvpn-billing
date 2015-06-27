class Admin::HomeController < Admin::BaseController
  def index
    @dashboard = Dto::Admin::Dashboard.new
  end
end

