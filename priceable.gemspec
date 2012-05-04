# -*- encoding: utf-8 -*-
require File.expand_path('../lib/priceable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Will Cosgrove"]
  gem.email         = ["will@willcosgrove.com"]
  gem.description   = %q{Super simple way to store prices}
  gem.summary       = %q{Quit storing prices the stupid way.  Get Priceable!}
  gem.homepage      = "http://github.com/willcosgrove/priceable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "priceable"
  gem.require_paths = ["lib"]
  gem.version       = Priceable::VERSION

  gem.add_development_dependency('rails')
  gem.add_development_dependency('rspec')
end
