# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "logfmtr/version"

Gem::Specification.new do |s|
  s.name        = "logfmtr"
  s.version     = Logfmtr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = %q{2015-06-30}
  s.authors     = ['Archana Sriram']
  s.email       = 'artistic.archana@gmail.com'
  s.homepage    = ""
  s.summary     = %q{a replacement for Logger::Formatter}
  s.description = %q{for formatting logs in logfmt}

  s.add_dependency "rake"
  s.add_development_dependency "rspec", "~>2.5.0"

  s.files         = `git ls-files`.split("\n")
  # s.files         = Dir['lib/*.rb']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
