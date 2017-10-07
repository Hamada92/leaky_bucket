require "test_helper"

class LeakyBucketTest < Minitest::Test

  def setup
    LeakyBucket.cache = ActiveSupport::Cache::MemoryStore.new
  end

   def test_it_creates_new_cache_entry_on_the_first_request
    #cache doesn't exist
    refute LeakyBucket.cache.read(1)

    LeakyBucket::Throttler.throttle(1)

    #cache exists
    assert LeakyBucket.cache.read(1)
  end

  def test_it_increments_the_bucket_load
    #first run to create cache
    3.times do 
      LeakyBucket::Throttler.throttle(1)
    end

    assert_equal LeakyBucket.cache.read(1)[:current_load], 3
  end

  def test_it_throws_an_error_when_burst_exceeded 
    11.times do 
      LeakyBucket::Throttler.throttle(1)
    end

    assert_raises(LeakyBucket::TooManyRequests) {LeakyBucket::Throttler.throttle(1)}

  end

  def test_that_it_has_a_version_number
    refute_nil ::LeakyBucket::VERSION
  end

end
