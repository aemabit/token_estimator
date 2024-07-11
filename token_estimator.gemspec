# frozen_string_literal: true

require_relative "lib/token_estimator/version"

Gem::Specification.new do |spec|
  spec.name = "token_estimator"
  spec.version = TokenEstimator::VERSION
  spec.authors = ["aemabit"]
  spec.email = ["am@connectnodes.io"]

  spec.summary = "A Rails engine for counting tokens in various types of files and text."
  spec.description = "TokenEstimator is a Rails gem that allows you to count tokens in Excel, CSV, PDF, TXT, Markdown, and input text files using different tokenizers."
  spec.homepage = "https://github.com/aemabit/token_estimator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aemabit/token_estimator"
  spec.metadata["changelog_uri"] = "https://github.com/aemabit/token_estimator/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", ">= 7.2.0.beta2"
  spec.add_dependency "roo", "~> 2.10", ">= 2.10.1"
  spec.add_dependency "pdf-reader", "~> 2.12"
  spec.add_dependency "tokenizers", "~> 0.5.0"
  spec.add_dependency "kramdown", "~> 2.4"
  spec.add_dependency "nokogiri", "~> 1.16", ">= 1.16.6"
  spec.add_dependency "csv", "~> 3.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
