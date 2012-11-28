# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'response_code_matchers/version'

Gem::Specification.new do |gem|
  gem.name          = "response_code_matchers"
  gem.version       = ResponseCodeMatchers::VERSION
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["r7kamura@gmail.com"]
  gem.description   = "Provide rspec matchers to match http response code"
  gem.summary       = "RSpec utility matchers for http response code"
  gem.homepage      = "https://github.com/r7kamura/response_code_matchers"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rack"
  gem.add_development_dependency "rspec"
end
