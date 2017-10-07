$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "leaky_bucket"
require 'active_support/cache'
require 'active_support/cache/memory_store'
require "minitest/autorun"
