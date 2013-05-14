module Synapse
  module ProcessManager
    module Mongo
      # Template for accessing collections needed by the process repository
      class Template < Common::Mongo::BaseTemplate
        # @return [String] Name of the collection containing processes
        attr_accessor :process_repository_name

        # @param [Mongo::MongoClient] client
        # @return [undefined]
        def initialize(client)
          super
          @process_repository_name = 'processes'
        end

        # @return [Mongo::Collection]
        def process_collection
          database.collection @process_repository_name
        end
      end # Template
    end # Mongo
  end # ProcessManager
end
