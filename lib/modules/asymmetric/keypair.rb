module Encryption
  class Keypair

    def initialize(size = 2048, password = nil)
      @keypair = OpenSSL::PKey::RSA.new(size)
      @password = password
    end

    def public_key
      PublicKey.new(@keypair.public_key.to_s, @password)
    end

    def private_key
      PrivateKey.new(@keypair.to_s, @password)
    end

    def self.generate(size = 2048, password = nil)
      keypair = OpenSSL::PKey::RSA.new(size)

      public_key = PublicKey.new(keypair.public_key.to_s, password)
      private_key = PrivateKey.new(keypair.to_s, password)

      return public_key, private_key
    end

  end
end