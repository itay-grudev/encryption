require 'openssl'

module Encryption
  class Symmetric
    
    def initialize
      @configuration = Encryption::Configuration::Symmetric.new
    end

    def method_missing(name, *args, &block)
      if @configuration.respond_to? name
        return @configuration.send(name, *args, &block)
      end
      super
    end

    def respond_to?(name)
      return true if @configuration.respond_to? name
      super
    end

    def encrypt(data)
      cipher_init(:cipher, :encrypt)
      @cipher.update(data) + @cipher.final
    end

    def decrypt(data)
      cipher_init(:decipher, :decrypt)
      @decipher.update(data) + @decipher.final
    end

    private

    def cipher_init(name, mode)
      obj = instance_variable_get((name = '@' + name.to_s))
      if obj.nil?
        obj = instance_variable_set(name, OpenSSL::Cipher.new(@configuration.cipher))
        obj.send mode
      end
      
      obj.key = @configuration.key
      obj.iv = @configuration.iv
    end

  end
end