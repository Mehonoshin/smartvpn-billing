# frozen_string_literal: true

require 'digest/md5'

class Signer
  def self.sign_hash(hash, key)
    Digest::MD5.hexdigest("#{hash.values.sort.join}#{key}")
  end

  def self.hashify_string(string)
    Digest::MD5.hexdigest(string)
  end
end
