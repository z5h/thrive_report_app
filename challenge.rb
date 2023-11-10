#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'dry-core', '~> 1.0'
  gem 'dry-struct', '~> 1.6'
  gem 'dry-types', '~> 1.7'
  gem 'dry-validation', '~> 1.10'
  gem 'dry-system', '~> 1.0'
  gem 'dry-logic', '~> 1.5'
  gem 'dry-cli', '~> 1.0'
end

$LOAD_PATH.unshift(File.expand_path('lib'))

require 'thrive_takehome'
Dry::CLI.new(ThriveTakehome::CLI::Commands).call
