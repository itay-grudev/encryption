require 'base64'

module Encryption
  module String

    def encrypt(options = {})
      string = encryptor(options).encrypt self
      string = Base64.encode64(string) if options[:encode]
      string
    end

    def decrypt(options = {})
      string = self
      string = Base64.decode64(self) if options[:encode] or options[:encoded]
      encryptor(options).decrypt string
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
      return options[:encryptor] if ! options[:encryptor].nil?

      encrypt = Encryption::Symmetric.new

      options.each do |key, value|
        encrypt.send(key.to_s + '=', value) if encrypt.respond_to? key.to_s + '='
      end

      encrypt
    end

  end
end