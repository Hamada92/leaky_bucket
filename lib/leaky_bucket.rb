require "leaky_bucket/version"
require "leaky_bucket/throttler"
require 'leaky_bucket/railtie' if defined?(Rails)

module LeakyBucket
  class << self
    attr_accessor :cache
  end
end
