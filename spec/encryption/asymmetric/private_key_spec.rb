require 'spec_helper'

describe Encryption::PrivateKey do

  describe do
    before(:each) do
      @key = Encryption::Keypair.new.private_key
    end

    it 'should generate encryption different than the original' do
      string = String.random
      @key.encrypt(string).should_not == string
    end
  end

  describe 'should export to' do
    before(:each) do
      @keypair = Encryption::Keypair.new
      @key = @keypair.private_key
    end

    it 'string' do
      @key.to_s.should be_an_instance_of(String)
    end

    it 'pem' do
      @key.to_s.should be_an_instance_of(String)
    end
  end

end