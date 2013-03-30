require 'spec_helper'
require 'openssl'

describe Encryption::Symmetric do
  
  it 'should be configurable with a block' do
    key = String.random
    iv = String.random
    cipher = String.random

    encryptor = Encryption::Symmetric.new

    encryptor.config do |config|
      config.key = key
      config.iv = iv
      config.cipher = cipher
    end

    encryptor.key.should == key
    encryptor.iv.should == iv
    encryptor.cipher.should == cipher
  end

  %x(openssl list-cipher-commands).split.each do |cipher|
    next if ! cipher[-3, 3].nil? and ['gcm', 'fb1'].include? cipher[-3, 3].downcase
    describe 'with cipher ' + cipher do

      before(:each) do
        @encryptor = Encryption::Symmetric.new
        @encryptor.cipher = cipher

        @string = String.random
        @encryptor.key = String.random
        @encryptor.iv = String.random
      end

      it 'should generate encryption different then the original string' do
        encrypted = @encryptor.encrypt(@string)
        encrypted.should_not == @string
      end

      it 'should decrypt, encrypted values and match the original string' do
        encrypted = @encryptor.encrypt(@string)
        decrypted = @encryptor.decrypt(encrypted)
        decrypted.should == @string
      end

    end
  end
    
end 