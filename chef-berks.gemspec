# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/berks/version'

Gem::Specification.new do |spec|
  spec.name          = "chef-berks"
  spec.version       = Chef::Berks::VERSION
  spec.authors       = ["Ranjib Dey"]
  spec.email         = ["dey.ranjib@gmail.com"]
  spec.description   = %q{Allows chef-client to grab cookbooks on the fly using berkshelf}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/ranjib/chef-berks"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chef"
  spec.add_dependency "berkshelf"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
