# frozen_string_literal: true

class NewsletterManager
  attr_reader :api

  def initialize
    @api = ::Gibbon::API.new(Settings.mailchimp.api_key)
  end

  def add_to_list(email, list_name)
    @api.lists.subscribe(id: list_id(list_name), email: { email: email })
  end

  private

  def list_id(list_name)
    list_ids_mapping[list_name.to_sym] || raise(SmartvpnException, 'Email list not defined')
  end

  def list_ids_mapping
    {
      all: all_clients_list_id
    }
  end

  def all_clients_list_id
    Settings.mailchimp.all_clients_list_id
  end
end
