require "test_helper"

class LeakyBucketTest < Minitest::Test

   def test_it_creates_new_cache_entry_on_the_first_request
    #cache doesn't exist
    assert_not Rails.cache.read(1)

    LeakyBucket::Throttler.throttle(1)

    #cache exists
    assert Rails.cache.read(1)
  end

  def test_that_it_has_a_version_number
    refute_nil ::LeakyBucket::VERSION
  end

end
