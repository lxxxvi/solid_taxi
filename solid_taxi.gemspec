require_relative "lib/solid_taxi/version"

Gem::Specification.new do |spec|
  spec.name        = "solid_taxi"
  spec.version     = SolidTaxi::VERSION
  spec.authors     = [ "Mario" ]
  spec.email       = [ "github@lxxxvi.ch" ]
  spec.homepage    = "https://github.com/lxxxvi/solid_taxi"
  spec.summary     = "Solid Taxi"
  spec.description = "Dashboard for Solid Queue"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  # TODO: Improve dependencies
  spec.add_dependency "rails", ">= 8.1.0"
end
