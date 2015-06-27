class RandomString
  DEFAULT_LENGTH = 8

  def self.generate(length=DEFAULT_LENGTH)
    (0...length).map{(65+rand(26)).chr}.join
  end
end
