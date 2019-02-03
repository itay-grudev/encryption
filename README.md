This project is currently stable, but will no longer be maintained.

Encryption
==========
[![Gem Version](https://badge.fury.io/rb/encryption.png)](http://badge.fury.io/rb/encryption)
[![Code Climate](https://codeclimate.com/github/Itehnological/encryption.png)](https://codeclimate.com/github/Itehnological/encryption)
[![Build Status](https://travis-ci.org/itay-grudev/encryption.png?branch=master)](https://travis-ci.org/itay-grudev/encryption)

A simple to use wrapper of the Ruby OpenSSL Cipher library for Ruby and Rails applications.
This gem provides an easy to use interface for symmetrical and asymmetrical encryption using RSA.

Documentation
-------------
Additional documentation and class reference can be found in the [Wiki section](https://github.com/itay-grudev/encryption/wiki) of the repository.

Installation
------------
Install the gem
```bash
gem install encryption
```
or add it to your `Gemfile`
```ruby
gem 'encryption'
```

## Symmetric encryption

### Using the global instance of the Encryption class

A simple example of how this gem works:

```ruby
Encryption.key = 'A very long encryption key'
data = 'secret data'
encrypted_str = Encryption.encrypt( data )
Encryption.decrypt( encrypted_str ) == data # true
```

### Using your own instance of the Encryption class

If you need a separate instance with custom settings, different than the global Encryption instance, here is how you can do it:
```ruby
encryptor = Encryption::Symmetric.new
encryptor.key = 'A very long encryption key'
data = 'secret data'
encrypted_str = encryptor.encrypt( data )
encryptor.decrypt( encrypted_str ) == data # true
```

### Configuration

For symmetric encryption/decryption you need to set an encryption key. You can also optionally set an initialization vector and a cipher.

`Encryption.key` - Your encryption key  
`Encryption.iv # Optional` - Encryption initialization vector. Defaults to the character `"\0"` _(Optional)_  
`Encryption.cipher # Optional` - Your encryption algorithm. Defaults to `aes-256-cbc` _(Optional)_
  
Running `openssl list-cipher-commands` in the terminal or calling `OpenSSL::Cipher.ciphers` in _Ruby_, which list all available ciphers.

You can configure both the global instance and a other instances with a _block_ like this:

```ruby
Encryption.config do |e|
    e.key = 'Don't look!'
    e.iv = 'This is probably the easiest way to use OpenSSL in Ruby'
    e.cipher = 'camellia-128-ecb' # if you're feeling adventurous
end
  ```

## Asymmetric encryption (public/private key encryption)

The `encryption` gem also provides a DSL for asymmetric encryption.

### Generating keypair

```ruby
keypair = Encryption::Keypair.new # Accepts two optional arguments: size = 2048, password = nil
keypair.public_key # Instance of Encryption::PublicKey
keypair.private_key # Instance of Encryption::PrivateKey
# Or you can use this shorter version
public_key, private_key = Encryption::Keypair.generate( 2048 )

# You can dump keys to string
private_key.to_s

# or export them to PEM format
private_key.to_pem

# and optionally encrypt them with a passphrase
private_key.to_pem( 'passphrase' )
```

### `Encryption::PublicKey` and `Encryption::PrivateKey`

Both classes have the same methods:

  ```ruby
# Import an existing key
Encryption::PrivateKey.new( filename[, password] ) # Import from file
Encryption::PrivateKey.new( string[, password] ) # Import from string

# Encrypt / Decrypt data
public_key = Encryption::PublicKey.new( 'existing key' )
public_key.encrypt( 'some secret data' )
public_key.decrypt( "some encrypted data" )
```

_Note: You can use both the public and the private key to encrypt or decrypt data._

## Helpers

### String helper

The gem adds the `encrypt` and `decrypt` methods to the `String` performing symmetric encryption. You can use them as follows:

```ruby
# With the global Encryption instance
'Hello'.encrypt
'Hello'.encrypt!
'h3LL0'.decrypt
'h3LL0'.decrypt!

# With custom settings (and custom encryptor instance)
'secret'.encrypt( key: 'encryption key', iv: 'initialization vector', cipher: 'encryption cipher', encode: true )
# Note the encode option which will result in a base64 encoded string

'encrypted data'.decrypt( encoded: true ) # Will decrypt a base64 encoded string

# Or with a custom encryptor
encryptor = Encryption::Symmetric.new
encryptor.key = 'encryption key'
'secret data'.encrypt( encryptor: encryptor )
```

License
-------
This gem is distributed under The MIT License.

Author
------
Itay Grudev \<itay(at)grudev...com\>
