require 'spec_helper'
require 'openssl'

describe Encryption do
  
  it 'should be configurable with a block' do
    key = String.random
    iv = String.random
    cipher = String.random

    Encryption.config do |config|
      config.key = key
      config.iv = iv
      config.cipher = cipher
    end

    Encryption.key.should == key
    Encryption.iv.should == iv
    Encryption.cipher.should == cipher
  end

  %x(openssl list-cipher-commands).split.each do |cipher|
    next if ['base64', 'zlib'].include? cipher
    
    describe 'with cipher ' + cipher do
      before(:each) do
        Encryption.cipher = cipher

        @string = String.random
        Encryption.key = String.random
        Encryption.iv = String.random
      end

      it 'should generate encryption different then the original string' do
        encrypted = Encryption.encrypt(@string)
        encrypted.should_not == @string
      end

      it 'should decrypt, encrypted values and match the original string' do
        encrypted = Encryption.encrypt(@string)
        decrypted = Encryption.decrypt(encrypted)
        decrypted.should == @string
      end

    end
  end
    
end 