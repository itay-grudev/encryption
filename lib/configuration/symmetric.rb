module Encryption
  module Configuration
    class Symmetric < Base

      def initialize
        super
        @config = {
          :key => nil,
          :iv => "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
          :cipher => 'aes-256-cbc'
        }
      end

    end
  end
end