module Synapse
  module Common
    module Mongo
      # Represents a mechanism for accessing collections required by a component
      # @abstract
      class BaseTemplate
        # @return [String] Name of the database to use
        attr_accessor :database_name

        # @return [String] Username to authenticate with (optional)
        attr_accessor :username

        # @return [String] Password to authenticate with (optional)
        attr_accessor :password

        # @param [Mongo::MongoClient] client
        # @return [undefined]
        def initialize(client)
          @client = client
          @database_name = 'synapse'
        end

      protected

        # @return [Mongo::DB]
        def database
          unless @database
            @database = @client.db @database_name

            if @username and @password
              @database.authenticate @username, @password
            end
          end

          @database
        end
      end # BaseTemplate
    end # Mongo
  end # Common
end
