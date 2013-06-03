module Synapse
  module Configuration
    # Definition builder used to create a Mongo-backed process repository
    #
    # @example The minimum possible effort to build a process repository
    #   mongo_process_repository do
    #     use_client Mongo::MongoClient.new
    #   end
    #
    # @example Mix it up a bit
    #   mongo_process_repository :alt_process_repository do
    #     use_resource_injector :alt_resource_injector
    #     use_serializer :alt_serializer
    #     use_template :alt_template
    #   end
    class MongoProcessRepositoryDefinitionBuilder < DefinitionBuilder
      # Convenience method that creates a process repository template with the given Mongo client
      #
      # @param [Mongo::MongoClient] client
      # @return [undefined]
      def use_client(client)
        @template = ProcessManager::Mongo::Template.new client
      end

      # Changes the serializer to use with this process repository
      #
      # @see Serialization::Serializer
      # @param [Symbol] serializer
      # @return [undefined]
      def use_serializer(serializer)
        @serializer = serializer
      end

      # Changes the Mongo template to use with this process repository
      #
      # @see ProcessManager::Mongo::Template
      # @param [Symbol] template
      # @return [undefined]
      def use_template(template)
        @template = template
      end

      # Changes the resource injector to use with this process repository
      #
      # @see ProcessManager::ResourceInjector
      # @param [Symbol] resource_injector
      # @return [undefined]
      def use_resource_injector(resource_injector)
        @resource_injector = resource_injector
      end

    protected

      # @return [undefined]
      def populate_defaults
        identified_by :process_repository

        use_resource_injector :resource_injector
        use_serializer :serializer
        use_template :mongo_process_repository_template

        use_factory do
          serializer = resolve @serializer
          template = resolve @template
          resource_injector = resolve @resource_injector, true

          process_repository = ProcessManager::Mongo::MongoProcessRepository.new serializer, template
          if resource_injector
            process_factory.resource_injector = resource_injector
          end

          process_repository
        end
      end
    end # MongoProcessRepositoryDefinitionBuilder
  end # Configuration
end
