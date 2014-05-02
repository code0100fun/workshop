# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workshop/version'

Gem::Specification.new do |spec|
  spec.name          = "workshop"
  spec.version       = Workshop::VERSION
  spec.authors       = ["Chase McCarthy"]
  spec.email         = ["chase@code0100fun.com"]
  spec.summary       = %q{A project managment toolset for the Arduino platform.}
  spec.description   = %q{A project managment toolset for the Arduino platform.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.bindir        = 'bin'
  spec.executables   = ['workshop']

  spec.add_dependency "activesupport"
  spec.add_dependency "thor"
  spec.add_dependency "colorize"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
