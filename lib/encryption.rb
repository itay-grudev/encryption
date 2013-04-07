require_relative 'configuration.rb'
require_relative 'modules.rb'
require_relative 'helpers.rb'

String.send(:include, Encryption::String)

module Encryption

  @@instance = nil # An instance to Encryption::Symmetric

  def self.method_missing(name, *args, &block)
    initalize_own_instance

    if @@instance.respond_to?(name)
      return @@instance.send(name, *args, &block)
    end

    super
  end

  def self.respond_to?(name, include_all = false)
    initalize_own_instance

    return true if @@instance.respond_to?(name)
    super
  end

  private

  def self.initalize_own_instance
    if @@instance.nil?
      @@instance = Encryption::Symmetric.new
    end
  end

end