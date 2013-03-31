require 'spec_helper'

describe String do

  it { should respond_to :encrypt }
  it { should respond_to :decrypt }
  it { should respond_to :encrypt! }
  it { should respond_to :decrypt! }

  describe "with global Encryption instance" do
    before(:each) do
      @string = String.random
      Encryption.key = String.random
    end

    it 'should generate encryption different then the original string' do
      @string.encrypt.should_not == @string
    end

    it 'should decrypt, encrypted values and match the original string' do
      @string.encrypt.decrypt.should == @string
    end
  end

  describe "with custom options" do
    before(:each) do
      @string = String.random
      @options = {
        :key => String.random,
        :iv => String.random
      }
    end

    it 'should generate encryption different then the original string' do
      @string.encrypt(@options).should_not == @string
    end

    it 'should decrypt, encrypted values and match the original string' do
      @string.encrypt(@options).decrypt(@options).should == @string
    end
  end

  describe "with custom encryptor" do
    before(:each) do
      @string = String.random
      encryptor = Encryption::Symmetric.new
      encryptor.key = String.random
      encryptor.iv = String.random
      @options = {
        encryptor: encryptor
      }
    end

    it 'should generate encryption different then the original string' do
      @string.encrypt(@options).should_not == @string
    end

    it 'should decrypt, encrypted values and match the original string' do
      @string.encrypt(@options).decrypt(@options).should == @string
    end
  end

  describe 'with encode option' do
    before(:each) do
      @string = String.random
      @options = {
        :key => String.random,
        :iv => String.random,
        :encode => true
      }
    end

    it 'should generate encryption different then the original string' do
      @string.encrypt(@options).should_not == @string
    end

    it 'should generate a valid base64' do
      (@string.encrypt(@options)=~/^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$/).should == 0
    end

    it 'should decrypt, encrypted values and match the original string' do
      @string.encrypt(@options).decrypt(@options).should == @string
    end
  end

end