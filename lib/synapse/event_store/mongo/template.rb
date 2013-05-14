module Synapse
  module EventStore
    module Mongo
      # Template for accessing collections needed by the event store
      class Template < Common::Mongo::BaseTemplate
        # @return [String] Name of the collection containing domain events
        attr_accessor :event_collection_name

        # @return [String] Name of the collection containing snapshot events
        attr_accessor :snapshot_collection_name

        # @param [Mongo::MongoClient] client
        # @return [undefined]
        def initialize(client)
          super

          @event_collection_name = 'domain_events'
          @snapshot_collection_name = 'snapshot_events'
        end

        # @return [Mongo::Collection]
        def event_collection
          database.collection @event_collection_name
        end

        # @return [Mongo::Collection]
        def snapshot_collection
          database.collection @snapshot_collection_name
        end
      end # Template
    end # Mongo
  end # EventStore
end
