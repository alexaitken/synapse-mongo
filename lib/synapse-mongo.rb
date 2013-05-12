require 'active_support'
require 'mongo'
require 'synapse'

require 'synapse/mongo/version'

module Synapse
  module Common
    # Utility classes used by Mongo components
    module Mongo
      extend ActiveSupport::Autoload

      autoload :BaseTemplate
    end
  end

  module EventStore
    autoload :Mongo
  end

  module Serialization
    autoload :OrderedHashToHashConverter, 'synapse/serialization/converter/bson'
  end
end
