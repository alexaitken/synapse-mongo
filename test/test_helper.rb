require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
end

require 'pp'
require 'test/unit'
require 'rr'
require 'synapse-mongo'

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end
