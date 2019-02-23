# frozen_string_literal: true

class AddUserToNewsletterWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'high'

  def perform(email, list_name)
    api = NewsletterManager.new
    api.add_to_list(email, list_name)
  end
end
