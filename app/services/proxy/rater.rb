# frozen_string_literal: true

module Proxy
  class Rater
    attr_accessor :user, :option

    def initialize(user, option)
      @user = user
      @option = option
    end

    def find_best
      activated_option = option.user_options.where(user_id: user.id).first
      country = activated_option.attrs['country']
      # TODO:
      # Strange situation, when proxy for selected country is not found
      Proxy::Node.where(country: country).order('ping ASC').first || Proxy::Node.first
    end
  end
end
