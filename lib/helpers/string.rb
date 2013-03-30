module Encryption
  module String

    def encrypt(options = {})
      encryptor(options).encrypt self
    end

    def decrypt(options = {})
      encryptor(options).decrypt self
    end

    def encrypt!(options = {})
      replace encrypt(options)
    end

    def decrypt!(options = {})
      replace decrypt(options)
    end

    private

    def encryptor(options)
      return Encryption if options.empty?

      encrypt = Encryption::Symmetric.new

      options.each do |key, value|
        encrypt.send(key.to_s + '=', value)
      end

      encrypt
    end

  end
end