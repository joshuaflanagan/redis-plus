# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis-plus/version'

Gem::Specification.new do |gem|
  gem.name          = "redis-plus"
  gem.version       = Redis::Plus::VERSION
  gem.authors       = ["Joshua Flanagan"]
  gem.email         = ["joshuaflanagan@gmail.com"]
  gem.description   = %q{Adds more general purpose redis commands}
  gem.summary       = %q{Adds more general purpose redis commands}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_dependency "redis", ">=3.0.0"
  gem.require_paths = ["lib"]
end
