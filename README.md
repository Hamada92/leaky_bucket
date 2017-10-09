# LeakyBucket

If you are running a busy application in production, you should limit the number of requests a user can make per time unit. LeakyBucket helps you do just that, easily.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leaky_bucket'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leaky_bucket

Then create a `leaky_bucket.rb` initializer file in `config/initializers` with :

```
LeakyBucket.cache = Rails.cache # or memcached
```


## Usage

to limit the requests to an action, use the `throttle` method: 

```ruby
def create
  LeakyBucket::Throttler.throttle(request.ip)
  #other code that will run if the user has not reached the maximum threshold.
end
```

the `throttle` method will raise an exception and return and 429 response code if the user has made too many requests.

By default, the threshold is 100 requests/hour, to override it, just provide the params:

```
# allow maximum 50 requests per minute.
LeakyBucket::Throttler.throttle(ip, threshold: 50, interval: 60, burst: 10)
```

`threhold` is the number of requests.

`interval` is in seconds.

`burst` is the number of requests the user is allowed to make at once, when the burst is exhausted, the user will have to wait until the sometime has passed to make another request.

## Development


To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/leaky_bucket. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LeakyBucket project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/leaky_bucket/blob/master/CODE_OF_CONDUCT.md).
