# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "logfmtr/version"

Gem::Specification.new do |s|
  s.name        = "logfmtr"
  s.version     = Logfmtr::VERSION
  s.licenses    = ['WTFPL']
  s.platform    = Gem::Platform::RUBY
  s.date        = %q{2015-06-30}
  s.authors     = ['Archana Sriram']
  s.email       = 'creativehandle@gmail.com'
  s.homepage    = "https://github.com/arachnid-cb/logfmtr"
  s.summary     = %q{a replacement for Logger::Formatter}
  s.description = %q{for formatting logs in logfmt}

  s.add_dependency "rake", "~> 10.4"
  s.add_development_dependency "rspec", "~> 3.3"
  s.add_development_dependency 'logfmt', '~> 0.0.7'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
