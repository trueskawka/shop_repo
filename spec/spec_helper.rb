ENV["RACK_ENV"] = "test"

require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.disable_monkey_patching!
end
