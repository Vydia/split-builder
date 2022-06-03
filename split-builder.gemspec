# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "builder/version"

Gem::Specification.new do |spec|
  spec.name          = "split-builder"
  spec.version       = SplitBuilder::VERSION
  spec.authors       = ["TSMMark"]
  spec.email         = ["dev@vydia.com"]

  spec.summary       = %q{A nice DSL for defining Experiments for the Split gem.}
  spec.description   = %q{No more struggling with big dumb Hashes when defining your Split Tests.}
  spec.homepage      = "http://github.com/Vydia/split-builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", "~>0.10"
  spec.add_development_dependency "bundler", ">= 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
