# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "githug/version"

Gem::Specification.new do |s|
  s.name        = "githug"
  s.version     = Githug::VERSION
  s.authors     = ["Gary Rennie"]
  s.email       = ["webmaster@gazler.com"]
  s.homepage    = "https://github.com/Gazler/githug"
  s.license     = "MIT"
  s.summary     = %q{An interactive way to learn git.}
  s.description = %q{A Ruby implemented game for the the CLI to learn core concepts of git.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~>2.8.0"

  s.add_dependency "grit", "~>2.5.0"
  s.add_dependency "thor", "~>1.3.1"
  s.add_dependency "rake", "~>13.1.0"
end
