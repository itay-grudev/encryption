Encryption
==========

[![Code Climate](https://codeclimate.com/github/Itehnological/encryption.png)](https://codeclimate.com/github/Itehnological/encryption)
[![Build Status](https://travis-ci.org/Itehnological/encryption.png)](https://travis-ci.org/Itehnological/encryption)

A simple wrapper for the OpenSSL Cipher library

Installation
------------
Run this command
```bash
gem install encryption
```
or add this line to your `Gemfile`
```ruby
gem "encryption"
```

Symmetric encryption
--------------------

  Using a global instance of the Encryption class
  -----------------------------------------------
  A simple example of how the gem works:
  ```ruby
Encryption.key = "Secretly yours,\n very long encryption key"
data = "this is to remain secret"
encrypted_str = Encryption.encrypt(data)
Encryption.decrypt(encrypted_str) == data # true
  ```

  Using own instance of the Encryption class
  ------------------------------------------
  Sometimes it is useful to use an own instance with custom settings, rather than the global Encryption instance. Here is how you can achieve it.
  ```ruby
encryptor = Encryption::Symmetric.new
encryptor.key = "Secretly yours,\n very long encryption key"
data = "this is to remain secret"
encrypted_str = encryptor.encrypt(data)
encryptor.decrypt(encrypted_str) == data # true
  ```

  Configuration
  -------------
  For symmetric encryption / decryption you need to set an encryption key. The rest of the settings are optional. Here is a list of all of them:  
  `Encryption.key` - Your encryption key  
  `Encryption.iv # Optional` - Encryption initialization vector. Defaults to the charecter `"\0"`  _(Optional)_  
  `Encryption.cipher # Optional` - Your encryption algorithm. Defaults to `aes-256-cbc` _(Optional)_  
  Run `openssl list-cipher-commands` in the terminal to list all installed ciphers or call `OpenSSL::Cipher.ciphers` in _Ruby_, which will return an array, containing all available algorithms.

  You can optionally configure both a global instance and a custom instance with a _block_:
  ```ruby
Encryption.config do |config|
  config.key = "don't look at me!"
  config.iv = "is there a better way to initialize OpenSSL?"
  config.cipher = "camellia-128-ecb" # if you feel adventurous
end
  ```

Asymmetric encryption (public/private key encryption)
-----------------------------------------------------
The `encryption` gem also provides easier synax for asymmetric encryption.

  Generating keypair
  ------------------
  ```ruby
keypair = Encryption::Keypair.new # Accepts two optional arguments size = 2048 and password = nil
keypair.public_key # Instance of Encryption::PublicKey
keypair.private_key # Instance of Encryption::PrivateKey
# Or this for short
public_key, private_key = Encryption::Keypair.generate(2048)

# Then you can export each to string
private_key.to_s

# or to PEM format
private_key.to_pem

# and optionally encrypt is with a passphrase
private_key.to_pem('passphrase')
  ```

  `Encryption::PublicKey` and `Encryption::PrivateKey`
  ----------------------------------------------------
  Both classes have the same methods

  ```ruby
# Import an existing key
Encryption::PublicKey.new(filename[, password]) # From file
Encryption::PublicKey.new(string[, password]) # From string

# Encrypt / Decrypt data
public_key = Encryption::PublicKey.new("existing key")
public_key.encrypt("2001: A Space Odyssey")
public_key.decrypt("H3LL0¡")

# Note that you can use both public and private keys to encrypt and decrypt data
  ```

Helpers
-------
  String helper
  -------------
  The gem adds the `encrypt` and `decrypt` methods to the `String` class.
  You can use them as follows:
  ```ruby
# With the global Encryption instance
"Hello".encrypt
"Hello".encrypt!
"h3LL0".decrypt
"h3LL0".decrypt!

# With custom settings (and custom encryptor instance)
"Contact".encrypt({ key: 'encryption key', iv: 'initialization vector', cipher: 'encryption algorithm' })

# Or with a custom encryptor
encryptor = Encryption::Symmetric.new
encryptor.key = 'random string'
"Interstate 60".encrypt(encryptor: encryptor)
  ```

License
-------
This gem is distributed under The MIT License.

  Author
  ------
  Itay Grudev  
  &nbsp;&nbsp;![Itay Grudev](http://safemail.justlikeed.net/e/a5307c0c2dd405f756cab9f4c76cd63a.png)
