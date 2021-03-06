require 'digest/sha2'
require 'openssl'
require 'cryptosphere/version'

require 'cryptosphere/crypto/asymmetric_cipher'
require 'cryptosphere/crypto/kdf'
require 'cryptosphere/crypto/signature_algorithm'

require 'cryptosphere/blobs/blob'
require 'cryptosphere/blobs/tree'

require 'cryptosphere/protocol/handshake'

require 'cryptosphere/cli'
require 'cryptosphere/head'
require 'cryptosphere/identity'

module Cryptosphere
  # How large of a key to use for the pubkey cipher
  PUBKEY_SIZE = 2048

  # Secure random data source
  def random_bytes(size)
    OpenSSL::Random.random_bytes(size)
  end

  # 256-bit hash function
  def self.hash_function
    Digest::SHA256.new
  end

  # 256-bit block cipher
  def self.block_cipher
    OpenSSL::Cipher::Cipher.new("aes-256-cbc")
  end

  # Request to do something we're incapable of
  class CapabilityError < StandardError; end

  # Signature doesn't match (potential data tampering)
  class InvalidSignatureError < StandardError; end

  # Implausible timestamps (i.e. ones from the future)
  class InvalidTimestampError < StandardError; end
end
