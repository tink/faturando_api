# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "faturando/version"

Gem::Specification.new do |s|
  s.name        = "faturando_api"
  s.version     = Faturando::VERSION
  s.authors     = ["Anderson Dias"]
  s.email       = ["andersondaraujo@gmail.com"]
  s.homepage    = "http://github.com/tink/faturando_api"
  s.rubyforge_project = "faturando_api"
  s.summary     = %q{A Faturando API wrapper for Ruby using ActiveResource}
  s.description = %q{A Faturando API wrapper for Ruby using ActiveResource}

  s.files         = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "faker"
  s.add_runtime_dependency "active_resource"
end
