require 'test_helper'

module Synapse
  module Common
    module Mongo

      class BaseTemplateTest < Test::Unit::TestCase
        def test_database
          client = Object.new
          database = Object.new

          database_name = 'test_database'
          username = 'test_username'
          password = 'test_password'

          mock(client).db(database_name) do
            database
          end

          mock(database).authenticate(username, password)

          template = BaseTemplate.new client
          template.database_name = database_name
          template.username = username
          template.password = password

          template.send :database
          # Additional calls to database should return the same database
          template.send :database
        end
      end

    end
  end
end
