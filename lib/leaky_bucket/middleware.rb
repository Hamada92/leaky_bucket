require 'leaky_bucket/throttler'

module LeakyBucket
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        @app.call(env)
      rescue LeakyBucket::TooManyRequests => e
        body = "Limit exceeded"
        headers = { "Content-Type" => "text/plain", "Content-Length" => 14, "Retry-After" => "#{e.retry_in}" }
        [ 429, headers, [ body ]]
      end
    end
  end
end