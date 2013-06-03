require 'active_support'
require 'mongo'
require 'synapse'

require 'synapse/mongo/version'
require 'synapse/configuration/mongo'

module Synapse
  module Common
    # Utility classes used by Mongo components
    module Mongo
      extend ActiveSupport::Autoload
      autoload :BaseTemplate
    end
  end

  module EventStore
    extend ActiveSupport::Autoload
    autoload :Mongo
  end

  module ProcessManager
    extend ActiveSupport::Autoload
    autoload :Mongo
  end

  module Serialization
    autoload :OrderedHashToHashConverter, 'synapse/serialization/converter/bson'
  end
end
