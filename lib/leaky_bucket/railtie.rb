require 'leaky_bucket/middleware'

module LeakyBucket
  class Railtie < Rails::Railtie
    initializer "my_railtie.configure_rails_initialization" do |app|
      app.middleware.use LeakyBucket::Middleware
    end
  end
end
