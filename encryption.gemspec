require 'date'

Gem::Specification.new do |s|
  s.name        = 'encryption'
  s.version     = '1.1.4'
  s.date        = Date.today.to_s
  s.summary     = 'A simple wrapper for the OpenSSL Cipher library'
  s.description = 'Encryption provides a simple interface for symmetric / asymmetric encryption with the OpenSSL Cipher library'
  s.authors     = ['Itay Grudev']
  s.email       = ['itay.grudev@gmail.com']
  s.homepage    = 'https://github.com/Itehnological/encryption'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.license = "MIT"
end