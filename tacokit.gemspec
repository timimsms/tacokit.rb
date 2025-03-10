# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tacokit/version"

Gem::Specification.new do |spec|
  spec.name          = "tacokit"
  spec.version       = Tacokit::VERSION
  spec.authors       = ["Ross Kaffenberger"]
  spec.email         = ["rosskaff@gmail.com"]
  spec.summary       = "A ruby toolkit for the Trello API."
  spec.description   = "A ruby toolkit for the Trello API."
  spec.homepage      = "https://rossta.net/tacokit.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "1.3.0"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "simple_oauth"
  spec.add_dependency "addressable"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"
end
