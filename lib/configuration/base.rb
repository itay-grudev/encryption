module Encryption
  module Configuration
    class Base

      def initialize
        @config = { }
      end

      def config
        yield self
      end

      def method_missing(name, *args)
          
        return @config[name.to_sym] if is_valid_getter(name)
        return @config[name[0..-2].to_sym] = args[0] if is_valid_setter(name)

        super
      end

      def respond_to?(name)
        return true if is_valid_getter(name) or is_valid_setter(name)
        super
      end

      private
      
      def is_valid_getter(name)
        @config.has_key? name.to_sym
      end

      def is_valid_setter(name)
        name = name.to_s
        name[-1, 1] == '=' and @config.has_key? name[0..-2].to_sym
      end

    end
  end
end