require "leaky_bucket/version"
require "leaky_bucket/throttler"

module LeakyBucket
  class << self
    attr_accessor :cache
  end
end
