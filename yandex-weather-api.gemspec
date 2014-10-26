# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yandex-weather-api/version'

Gem::Specification.new do |spec|
  spec.name          = "yandex-weather-api"
  spec.version       = YandexWeather::VERSION
  spec.authors       = ["Dmitry Kontsevoy"]
  spec.email         = ["dmitry.kontsevoj@gmail.com"]
  spec.summary       = %q{Ruby wrapper to yandex weather api}
  spec.homepage      = "https://github.com/h3xby/yandex-weather-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
