require 'synapse/configuration/process_manager/mongo/process_repository'

module Synapse
  module Configuration
    class ContainerBuilder
      # Creates and configures a Mongo process repository
      builder :mongo_process_repository, MongoProcessRepositoryDefinitionBuilder
    end # ContainerBuilder
  end # Configuration
end
