# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naver/searchad/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'naver-searchad-api'
  spec.version       = Naver::Searchad::Api::VERSION
  spec.authors       = ['Min Kim']
  spec.email         = %w[developers@forward3d.com min.kim@forward3d.com]

  spec.summary       = %q(Naver Searchad API ruby client)
  spec.description   = %q(Naver Searchad API ruby client)
  spec.homepage      = 'https://github.com/forward3d/naver-searchad-api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httpclient', '>= 2.8.1', '< 3.0'
  spec.add_runtime_dependency 'addressable', '~> 2.5'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'webmock', '~> 3.12'
end
