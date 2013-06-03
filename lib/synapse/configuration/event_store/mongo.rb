require 'synapse/configuration/event_store/mongo/event_store'

module Synapse
  module Configuration
    class ContainerBuilder
      # Creates and configures a Mongo event store
      builder :mongo_event_store, MongoEventStoreDefinitionBuilder
    end # ContainerBuilder
  end # Configuration
end
