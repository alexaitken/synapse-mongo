module Synapse
  module Configuration
    # Definition builder used to create a Mongo-backed event store
    #
    # @example The minimum possible effort to build an event store
    #   mongo_event_store do
    #     use_client Mongo::MongoClient.new
    #   end
    #
    # @example Mix it up a bit
    #   mongo_event_store :alt_event_store do
    #     use_per_event_strategy
    #
    #     use_serializer :alt_serializer
    #     use_upcaster_chain :alt_upcaster_chain
    #     use_template :alt_template
    #   end
    class MongoEventStoreDefinitionBuilder < DefinitionBuilder
      # Convenience method that creates an event store template with the given Mongo client
      #
      # @param [Mongo::MongoClient] client
      # @return [undefined]
      def use_client(client)
        @template = EventStore::Mongo::Template.new client
      end

      # Changes the type of storage strategy to document-per-commit
      #
      # @see EventStore::Mongo::DocumentPerCommitStrategy
      # @return [undefined]
      def use_per_commit_strategy
        @storage_strategy_type = EventStore::Mongo::DocumentPerCommitStrategy
      end

      # Changes the type of storage strategy to document-per-event
      #
      # @see EventStore::Mongo::DocumentPerEventStrategy
      # @return [undefined]
      def use_per_event_strategy
        @storage_strategy_type = EventStore::Mongo::DocumentPerEventStrategy
      end

      # Changes the serializer to use with this event store
      #
      # @see Serialization::Serializer
      # @param [Symbol] serializer
      # @return [undefined]
      def use_serializer(serializer)
        @serializer = serializer
      end

      # Changes the Mongo template to use with this event store
      #
      # @see EventStore::Mongo::Template
      # @param [Symbol] template
      # @return [undefined]
      def use_template(template)
        @template = template
      end

      # Changes the upcaster chain to use with this event store
      #
      # @see Upcasting::UpcasterChain
      # @param [Symbol] upcaster_chain
      # @return [undefined]
      def use_upcaster_chain(upcaster_chain)
        @upcaster_chain = upcaster_chain
      end

    protected

      # @return [undefined]
      def populate_defaults
        identified_by :event_store

        use_serializer :serializer
        use_per_commit_strategy
        use_template :mongo_event_store_template
        use_upcaster_chain :upcaster_chain

        use_factory do
          serializer = resolve @serializer
          template = resolve @template
          upcaster_chain = resolve @upcaster_chain

          strategy = @storage_strategy_type.new template, serializer, upcaster_chain

          event_store = EventStore::Mongo::MongoEventStore.new template, strategy
          event_store.ensure_indexes

          event_store
        end
      end
    end # MongoEventStoreDefinitionBuilder
  end # Configuration
end
