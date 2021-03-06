# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/lokalise/version"

Gem::Specification.new do |spec|
  spec.name = "ruboty-lokalise"
  spec.version = Ruboty::Lokalise::VERSION
  spec.authors = ["Michikawa Masayoshi"]
  spec.email = ["michikawa.masayoshi@gmail.com"]

  spec.summary = "Ruboty plugin for lokalise."
  spec.description = "Ruboty plugin for lokalise."
  spec.homepage = "https://github.com/michiomochi/ruboty-lokalise"
  spec.license = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty", "~> 1"
  spec.add_dependency "ruby-lokalise-api", "~> 2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
end
