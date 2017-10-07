module LeakyBucket
  
  class TooManyRequests < StandardError
    attr_accessor :retry_in

    def initialize(retry_in)
      self.retry_in = retry_in
    end
  end

  class Throttler

    class << self
      def throttle(ip, threshold: 100, interval: 3600, burst: 10)
        bucket = Rails.cache.read(ip) || new_counter

        #leak proper number of requests since last request time.
        bucket = leak(bucket)

        if bucket[:current_load] > burst
          raise LeakyBucket::TooManyRequests.new((interval/threshold) - (Time.now.to_i - bucket[:last_request_made_at]))
        end

        increment(ip, bucket)
      end

      private

      def leak(bucket)
        now = Time.now.to_i
        #the bucket leaks 100 requests/hour by default ~= 1.6 request/minute 
        leak_rate = interval / threshold
        leak_amount = (now - bucket[:last_request_made_at]) / leak_rate
        #decrement the bucket load, or empty it if it's been a long enough time for it to leak everything
        bucket[:current_load] = [bucket[:current_load] - leak_amount, 0].max
        bucket
      end

      def increment(ip, bucket)
        bucket[:current_load] += 1
        bucket[:last_request_made_at] = Time.now.to_i
        Rails.cache.write(ip, bucket)
      end

      #used as a cache key for the first api request from this IP address
      def new_counter
        { current_load: 0, last_request_made_at: 0 }
      end
    end

  end
end
