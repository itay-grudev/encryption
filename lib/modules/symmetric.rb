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
      cipher_init
      @cipher.update(data) + @cipher.final
    end

    def decrypt(data)
      decipher_init
      @decipher.update(data) + @decipher.final
    end

    private
    
    def cipher_init
      if @cipher.nil?
        @cipher = OpenSSL::Cipher.new(@configuration.cipher)
        @cipher.encrypt
      end

      @cipher.key = @configuration.key
      @cipher.iv = @configuration.iv
    end

    def decipher_init
      if @decipher.nil?
        @decipher = OpenSSL::Cipher.new(@configuration.cipher)
        @decipher.decrypt
      end

      @decipher.key = @configuration.key
      @decipher.iv = @configuration.iv
    end

  end
end