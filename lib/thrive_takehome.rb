# frozen_string_literal: true

require_relative "thrive_takehome/version"
require 'thrive_takehome/report'
require "dry/cli"
require 'reporting_error'

module ThriveTakehome

  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts ThriveTakehome::VERSION
        end
      end

      class TopUpReport < Dry::CLI::Command

        desc "Run a Top Up Report for a given company and user file"

        argument :company_file_path, type: :string, required: true, desc: "The company file"
        argument :user_file_path, type: :string, required: true, desc: "The user file"

        example ["path/to/companies.json path/to/users.json"]

        def call(company_file_path:, user_file_path:, **)
          begin
            company_file = File.read(company_file_path)
          rescue Errno::ENOENT => e
            puts "File not found: #{company_file_path}"
            exit(1)
          rescue Errno::EACCES => e
            puts "Permission denied: #{company_file_path}"
            exit(1)
          end

          begin
            user_file = File.read(user_file_path)
          rescue Errno::ENOENT => e
            puts "File not found: #{user_file_path}"
            exit(1)

          rescue Errno::EACCES => e
            puts "Permission denied: #{user_file_path}"
            exit(1)
          end

          begin
            puts Report.report(company_file, user_file)
          rescue ReportingError => e
            puts e.message
            exit(1)
          end
        end
      end

      register "report", TopUpReport, aliases: ["r", "-r", "--report"]
      register "version", Version, aliases: ["v", "-v", "--version"]

    end
  end
end
