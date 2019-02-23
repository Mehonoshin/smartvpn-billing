# frozen_string_literal: true

class Option::Deactivator
  def self.run(user, option_id)
    option = Option.active.find(option_id)
    user.options.delete(option)
  end
end
