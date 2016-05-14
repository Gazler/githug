# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "githug/version"

Gem::Specification.new do |s|
  s.name        = "githug"
  s.version     = Githug::VERSION
  s.authors     = ["Kamila Kupidura", "Tomasz Wierzchowski", "Daniel Dec"]
  s.email       = ["kkupidura@future-processing.com", "twierzchowski@future-processing.com", "ddec@future-processing.com"]
  s.homepage    = "https://github.com/FP-QAs/githug"
  s.summary     = %q{Warsztaty z git dla testerów (TestingCup 2016).}
  s.description = %q{Warsztaty z git dla testerów (TestingCup 2016).}
  s.license     = "MIT"

  s.rubyforge_project = "githug"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~>2.8.0"

  s.add_dependency "grit", "~>2.3.0"
  s.add_dependency "thor", "~>0.14.6"
  s.add_dependency "rake"
  # s.add_runtime_dependency "rest-client"
end
