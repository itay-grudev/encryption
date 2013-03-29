require 'spec_helper'
require 'openssl'

describe Encryption::Keypair do

  it 'should generate keypairs with generate static method' do
    public_key, private_key = Encryption::Keypair.generate
    public_key.should be_an_instance_of(Encryption::PublicKey)
    private_key.should be_an_instance_of(Encryption::PrivateKey)
  end

  it 'should generate keypairs with keypair instance' do
    keypair = Encryption::Keypair.new
    keypair.public_key.should be_an_instance_of(Encryption::PublicKey)
    keypair.private_key.should be_an_instance_of(Encryption::PrivateKey)
  end

end