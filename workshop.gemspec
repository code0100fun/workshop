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
  spec.description   = %q{An Arduino project build system designed to make Arduino development more fun and less... crappy.}
  spec.homepage      = "https://github.com/code0100fun/workshop"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.bindir        = 'bin'
  spec.executables   = ['workshop']

  spec.add_dependency "activesupport", "~>4.1"
  spec.add_dependency "thor", "~>0.19"
  spec.add_dependency "colorize", "~>0.7"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry", "~>0.9"
end
