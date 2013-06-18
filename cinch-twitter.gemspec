# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/twitter/version'

Gem::Specification.new do |spec|
  
  spec.name          = "cinch-twitter"
  spec.version       = Cinch::Twitter::VERSION
  spec.authors       = ["Mark Seymour"]
  spec.email         = ["mark.seymour.ns@gmail.com"]
  spec.description   = %q{A Twitter plugin for Cinch.}
  spec.summary       = %q{A Cinch plugin for accessing Twitter.}
  spec.homepage      = "https://github.com/mseymour/cinch-twitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Gem dependencies
  spec.add_dependency 'twitter', '~> 4.8'
  spec.add_dependency 'cinch', '~> 2.0'
  spec.add_dependency "oj", "~> 2.0.14"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
