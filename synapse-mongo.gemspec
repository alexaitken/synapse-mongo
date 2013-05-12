$:.push File.expand_path '../lib', __FILE__

require 'synapse/mongo/version'

Gem::Specification.new do |s|
  s.name = 'synapse-mongo'
  s.version = Synapse::Mongo::VERSION.dup
  s.author = 'Ian Unruh'
  s.email = 'ianunruh@gmail.com'
  s.homepage = 'https://github.com/iunruh/synapse-mongo'
  s.description = 'A versatile CQRS and event sourcing framework'
  s.summary = 'A versatile CQRS and event sourcing framework'

  s.files = Dir.glob '{lib,test}/**/*'
  s.require_path = 'lib'

  s.add_dependency 'synapse-core', '>= 0.2.0'
  s.add_dependency 'mongo'
end
