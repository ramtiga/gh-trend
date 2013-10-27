# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gh-trend/version'

Gem::Specification.new do |spec|
  spec.name          = "gh-trend"
  spec.version       = GhTrend::VERSION
  spec.authors       = ["ramtiga"]
  spec.email         = ["dhanegm731@gmail.com"]
  spec.description   = %q{Get Trending repositories on Github for CLI.}
  spec.summary       = %q{Get Trending repositories on Github for CLI.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.11.0"
  spec.add_dependency "launchy", "~> 2.3.0"
  spec.add_dependency "netrc", "~> 0.7.7"
  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_dependency "octokit", "~> 2.4.0"
  spec.add_dependency "slop", "~> 3.4.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.10.0"
  spec.add_development_dependency "webmock", "1.15.0"
end
