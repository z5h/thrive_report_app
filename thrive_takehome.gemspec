# frozen_string_literal: true

require_relative "lib/thrive_takehome/version"

Gem::Specification.new do |spec|
  spec.name = "thrive_takehome"
  spec.version = ThriveTakehome::VERSION
  spec.authors = ["Mark Bolusmjak"]
  spec.email = ["my_last_name@googles_mail_service.com"]

  spec.summary = "Thrive's Takehome Challenge"
  spec.description = """
    Given a json file of users, and
    Given a json file of companies:

    Create code in Ruby that process these files and creates an
    output.txt file.

    Criteria for the output file:
    Any user that belongs to a company in the companies file and is active
    needs to get a token top up of the specified amount in the companies top up
    field.

    If the users company email status is true indicate in the output that the
    user was sent an email ( don't actually send any emails).
    However, if the user has an email status of false, don't send the email
    regardless of the company's email status.

    Companies should be ordered by company id.
    Users should be ordered alphabetically by last name."""

  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-core", "~> 1.0"
  spec.add_dependency "dry-struct", "~> 1.6"
  spec.add_dependency "dry-types", "~> 1.7"
  spec.add_dependency "dry-validation", "~> 1.10"
  spec.add_dependency "dry-system", "~> 1.0"
  spec.add_dependency "dry-logic", "~> 1.5"
  spec.add_dependency "dry-cli", "~> 1.0"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
