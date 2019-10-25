# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-alibaba-cainiao-environment/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-alibaba-cainiao-environment'
  spec.version       = CocoapodsAlibabaCainiaoEnvironment::VERSION
  spec.authors       = ['亿刀']
  spec.email         = ['laiqiang.zlq@taobao.com']
  spec.description   = %q{A short description of cocoapods-alibaba-cainiao-environment.}
  spec.summary       = %q{A longer description of cocoapods-alibaba-cainiao-environment.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-alibaba-cainiao-environment'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
