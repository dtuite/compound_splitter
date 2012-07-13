# -*- encoding: utf-8 -*-
require File.expand_path('../lib/compound_splitter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Tuite"]
  gem.email         = ["dtuite@gmail.com"]
  gem.description   = %q{Split concatenated words}
  gem.summary       = %q{Split words which have been concatenated together. eg. 'wickedweather' -> 'wicked weather'}
  gem.homepage      = "https://github.com/dtuite/compound_splitter"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "compound_splitter"
  gem.require_paths = ["lib"]
  gem.version       = CompoundSplitter::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
