require 'openssl'

module Encryption
  class PrivateKey < PKey

    def encrypt(data)
      @key.private_encrypt(data)
    end

    def decrypt(data)
      @key.private_decrypt(data)
    end

  end
end