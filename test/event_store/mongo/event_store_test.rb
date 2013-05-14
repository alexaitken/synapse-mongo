require 'test_helper'

module Synapse
  module EventStore
    module Mongo

      class MongoEventStoreTest < Test::Unit::TestCase
        def test_integration
          client = ::Mongo::MongoClient.new
          template = Template.new client
          template.event_collection.drop
          template.snapshot_collection.drop

          converter_factory = Serialization::ConverterFactory.new
          serializer = Serialization::MarshalSerializer.new converter_factory
          upcaster_chain = Upcasting::UpcasterChain.new converter_factory

          [DocumentPerCommitStrategy, DocumentPerEventStrategy].each do |type|
            strategy = type.new template, serializer, upcaster_chain
            test_integration_with template, strategy
          end

        end

      private

        def test_integration_with(template, strategy)
          store = MongoEventStore.new template, strategy
          store.ensure_indexes

          type_identifier = 'TestAggregate'

          metadata = {
            foo: 0,
            bar: 1
          }
          payload = TestEvent.new 1, 2
          aggregate_id = SecureRandom.uuid


          x = 0

          # Create two sets of 50 events each
          # After this, we'll add an artificial snapshot at seq num 49
          2.times do
            events = Array.new

            50.times do
              events.push create_event metadata, payload, aggregate_id, x
              x = x.next
            end

            append_stream = Domain::SimpleDomainEventStream.new events
            store.append_events type_identifier, append_stream
          end

          read_stream = store.read_events type_identifier, aggregate_id
          read_array = read_stream.to_a

          assert_equal 100, read_array.count

          snapshot = create_event metadata, payload, aggregate_id, 49
          store.append_snapshot_event type_identifier, snapshot

          read_stream = store.read_events type_identifier, aggregate_id
          read_array = read_stream.to_a

          assert_equal 51, read_array.count
        end

        def create_event(metadata, payload, aggregate_id, sequence_number)
          Domain::DomainEventMessage.build do |builder|
            builder.metadata = metadata
            builder.payload = payload
            builder.aggregate_id = aggregate_id
            builder.sequence_number = sequence_number
          end
        end
      end

      class TestEvent
        attr_accessor :foo
        attr_accessor :bar

        def initialize(foo, bar)
          @foo, @bar = foo, bar
        end
      end

    end
  end
end
