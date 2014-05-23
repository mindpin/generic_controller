# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generic_controller/version'

Gem::Specification.new do |spec|
  spec.name          = "generic_controller"
  spec.version       = GenericController::VERSION
  spec.authors       = ["Kaid"]
  spec.email         = ["kaid@kaid.me"]
  spec.summary       = %q{Helper methods for single model instance controller actions.}
  spec.description   = %q{Helper methods for single model instance controller actions.}
  spec.homepage      = "https://github.com/mindpin/generic_controller"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "actionpack", "~> 4.1.0"
  spec.add_dependency "activemodel", "~> 4.1.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
