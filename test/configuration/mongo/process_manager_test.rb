require 'test_helper'

module Synapse
  module Configuration
    class MongoProcessRepositoryDefinitionBuilderTest < Test::Unit::TestCase

      def setup
        @container = Container.new
        @builder = ContainerBuilder.new @container
      end

      should 'build with sensible defaults' do
        @builder.converter_factory
        @builder.serializer

        @builder.mongo_process_repository do
          use_client ::Mongo::MongoClient.new
        end

        repository = @container.resolve :process_repository

        assert_instance_of ProcessManager::Mongo::MongoProcessRepository, repository
      end

    end
  end
end
