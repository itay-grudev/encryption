require 'rubygems'
require 'bundler/setup'

require 'encryption'

class String
  def self.random
    Digest::SHA256.hexdigest(([Time.now.to_s] * rand(3)).join)
  end
end