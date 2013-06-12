# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/twitter/version'

Gem::Specification.new do |gem|
  gem.add_dependency 'twitter', '~> 4.8'
  gem.add_dependency 'cinch', '~> 2.0'

  gem.name          = "cinch-twitter"
  gem.version       = Cinch::Plugins::Twitter::VERSION
  gem.authors       = ["Mark Seymour"]
  gem.email         = ["mark.seymour.ns@gmail.com"]
  gem.description   = %q{A Twitter plugin for Cinch.}
  gem.summary       = %q{A Cinch plugin for accessing Twitter.}
  gem.homepage      = "https://github.com/mseymour/cinch-twitter"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
