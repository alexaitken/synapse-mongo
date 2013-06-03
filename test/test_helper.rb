require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
end

require 'pp'
require 'test/unit'
require 'rr'
require 'synapse-mongo'

# I guess RR broke
# http://stackoverflow.com/questions/3657972
unless defined? Test::Unit::AssertionFailedError
  Test::Unit::AssertionFailedError = ActiveSupport::TestCase::Assertion
end
