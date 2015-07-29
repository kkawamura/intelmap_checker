# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intelmap_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "intelmap_checker"
  spec.version       = IntelmapChecker::VERSION
  spec.authors       = ["kkawamura"]
  spec.email         = ["kawamura.keisuke@gmail.com"]

  spec.summary       = %q{Simple tool to collect some information from intelmap in INGRESS}
  spec.description   = %q{Simple tool to collect some information from intelmap in INGRESS}
  spec.homepage      = "http://github.com/kkawamura/intelmap_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "selenium-webdriver"
end
