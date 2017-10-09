# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "leaky_bucket/version"

Gem::Specification.new do |spec|
  spec.name          = "leaky_bucket"
  spec.version       = LeakyBucket::VERSION
  spec.authors       = ["Ahmad"]
  spec.email         = ["ahmad.kaate@gmail.com"]

  spec.summary       = %q{limit the number of requests made to your api using the solid leaky bucket algorithm}
  spec.homepage      = "https://github.com/Hamada92/leaky_bucket"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency('activesupport')
end
