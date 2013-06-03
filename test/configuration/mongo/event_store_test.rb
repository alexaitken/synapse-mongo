require 'test_helper'

module Synapse
  module Configuration
    class MongoEventStoreDefinitionBuilderTest < Test::Unit::TestCase

      def setup
        @container = Container.new
        @builder = ContainerBuilder.new @container
      end

      should 'build with sensible defaults' do
        @builder.converter_factory
        @builder.serializer
        @builder.upcaster_chain

        @builder.mongo_event_store do
          use_client ::Mongo::MongoClient.new
        end

        event_store = @container.resolve :event_store

        assert_instance_of EventStore::Mongo::MongoEventStore, event_store
      end

    end
  end
end
