module Encryption
  class PKey

    def initialize(data, password = nil)
      if File.exist?(data)
        data = File.read(data)
      end

      if password.nil?
        @key = OpenSSL::PKey::RSA.new(data)
      else
        @key = OpenSSL::PKey::RSA.new(data, password)
      end
    end

    def to_s
      @key.to_s
    end

    def to_pem(password = nil)
      if password.nil? or password.empty?
        return @key.to_pem
      end

      cipher = OpenSSL::Cipher::Cipher.new('des3')
      @key.to_pem(cipher, password)
    end

  end
end