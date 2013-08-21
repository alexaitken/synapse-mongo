$:.push File.expand_path '../lib', __FILE__

require 'synapse/mongo/version'

Gem::Specification.new do |s|
  s.name = 'synapse-mongo'
  s.version = Synapse::Mongo::VERSION.dup
  s.author = 'Ian Unruh'
  s.email = 'ianunruh@gmail.com'
  s.license = 'Apache 2.0'
  s.homepage = 'https://github.com/ianunruh/synapse-mongo'
  s.description = 'MongoDB implementations for the Synapse CQRS framework'
  s.summary = 'MongoDB implementations for the Synapse CQRS framework'

  s.files = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.test_files = Dir['test/**/*']
  s.require_path = 'lib'

  s.add_dependency 'synapse-core', '~> 0.5.6'
  s.add_dependency 'mongo'
end
