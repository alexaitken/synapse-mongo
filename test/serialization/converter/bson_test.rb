require 'test_helper'

module Synapse
  module Serialization
    class OrderedHashToHashConverterTest < Test::Unit::TestCase
      def test_convert
        converter = OrderedHashToHashConverter.new

        assert_equal BSON::OrderedHash, converter.source_type
        assert_equal Hash, converter.target_type

        source = BSON::OrderedHash.new
        source[:foo] = 0
        source[:bar] = BSON::OrderedHash.new
        source[:bar][:baz] = 1

        target = {
          :foo => 0,
          :bar => {
            :baz => 1
          }
        }

        assert_equal target, converter.convert_content(source)
      end
    end
  end
end
