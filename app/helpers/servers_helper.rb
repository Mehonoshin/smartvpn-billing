module ServersHelper
  def server_country_name(server)
    server.country_code
  end

  def countries_for_select
    JSON.parse(File.read('config/countries.json'))['ru'].map do |code, name|
      [code, name]
    end
  end
end
