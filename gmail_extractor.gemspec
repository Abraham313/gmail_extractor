# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gmail_extractor/version"

Gem::Specification.new do |s|
  s.name        = "gmail_extractor"
  s.version     = GmailExtractor::VERSION
  s.authors     = ["Simon Harrer"]
  s.email       = ["simon.harrer@gmail.com"]
  s.homepage    = 'https://github.com/simonharrer/gmail_extractor'
  s.summary     = %q{Downloads emails from Google Mail to XML, CSV or HTML}
  s.description = s.summary

  s.rubyforge_project = "gmail_extractor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "gmail"
  s.add_runtime_dependency "progressbar"
  s.add_runtime_dependency "highline"
end
