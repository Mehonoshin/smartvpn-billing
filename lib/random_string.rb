# frozen_string_literal: true

class RandomString
  DEFAULT_LENGTH = 8

  def self.generate(length = DEFAULT_LENGTH)
    (0...length).map { rand(65..90).chr }.join
  end
end
