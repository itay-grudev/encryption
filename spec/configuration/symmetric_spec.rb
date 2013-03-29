require 'spec_helper'


describe Encryption::Configuration::Symmetric do
  
  it 'should be configurable with a block' do
    key = String.random
    iv = String.random
    cipher = String.random

    @config = Encryption::Configuration::Symmetric.new
    @config.config do |config|
      config.cipher = cipher
      config.key = key
      config.iv = iv
    end

    @config.key.should == key
    @config.iv.should == iv
    @config.cipher.should == cipher
  end

  describe 'should set and return' do
    before(:each) do
      @config = Encryption::Configuration::Symmetric.new
    end

    it 'key' do
      value = String.random
      @config.key = value
      @config.key.should == value
    end

    it 'iv' do
      value = String.random
      @config.iv = value
      @config.iv.should == value
    end

    it 'cipher' do
      value = String.random
      @config.cipher = value
      @config.cipher.should == value
    end
  end

end