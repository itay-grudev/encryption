require 'spec_helper'

describe 'Encryption::Asymmetric' do

  before(:each) do
    @string = String.random
    keypair = Encryption::Keypair.new
    @public_key = keypair.public_key
    @private_key = keypair.private_key
  end

  it 'should encrypt with public key and then decrypt with private key' do
    encrypted = @public_key.encrypt(@string)
    @private_key.decrypt(encrypted).should == @string
  end

  it 'should encrypt with private key and then decrypt with public key' do
    encrypted = @private_key.encrypt(@string)
    @public_key.decrypt(encrypted).should == @string
  end

end