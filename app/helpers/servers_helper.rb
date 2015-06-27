module ServersHelper
  def server_country_flag(server)
    country_name = WorldFlags.country_by_code(server.country_code, I18n.locale)
    flag_with_title server.country_code, country_name
  end

  def countries_for_select
    WorldFlags.countries_mapping(I18n.locale)
  end
end
