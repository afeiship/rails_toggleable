# rails_toggleable.gemspec
$:.push File.expand_path("lib", __dir__)

require "rails_toggleable/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_toggleable"
  spec.version     = RailsToggleable::VERSION
  spec.authors     = ["aric.zheng"]
  spec.email       = ["1290657123@qq.com"]

  spec.summary     = "A Rails plugin for configurable boolean toggle fields."
  spec.description = "Provides an easy way to add toggleable boolean fields (e.g., active, enabled) to Rails models with dynamic methods and scopes."
  spec.homepage    = "https://github.com/afeiship/rails_toggleable"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0.0"
end