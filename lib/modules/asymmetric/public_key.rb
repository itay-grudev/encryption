require 'openssl'

module Encryption
  class PublicKey < PKey

    def encrypt(data)
      @key.public_encrypt(data)
    end

    def decrypt(data)
      @key.public_decrypt(data)
    end

  end
end