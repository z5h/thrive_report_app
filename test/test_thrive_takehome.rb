# frozen_string_literal: true

require "test_helper"
require "thrive_takehome"
require 'reporting_error'

class TestThriveTakehome < Minitest::Test

  def setup
    # create a temporary file with write permission but not read permission
    @temp_file = Tempfile.new('temp_file')
    @temp_file.chmod(0222)
    @not_json_file = "test/fixtures/example_output.txt"
    @expected_output = File.read("test/fixtures/example_output.txt")
  end

  def teardown
    @temp_file.unlink
  end

  def test_cli_bad_file_name
    assert_output(/File not found/) do
      assert_raises SystemExit do
        Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['report', 'a_bad_file_name','a_bad_file_name'])
      end
    end
  end

  def test_cli_bad_file_permission
    assert_output(/Permission denied/) do
      assert_raises SystemExit do
        Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['report', @temp_file.path, @temp_file.path])
      end
    end
  end

  def test_cli_bad_json
    assert_output(/Invalid JSON in/) do
      assert_raises SystemExit do
        Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['report', @not_json_file, @not_json_file])
      end
    end
  end

  def test_cli_good_json_unexpected_data
    assert_output(/Invalid company data/) do
      assert_raises SystemExit do
        Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['report', 'test/fixtures/users.json', 'test/fixtures/users.json'])
      end
    end
  end

  def test_cli_success
    assert_output(@expected_output) do
      Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['report', 'test/fixtures/companies.json', 'test/fixtures/users.json'])
    end
  end

  def test_cli_version
    assert_output( /#{Regexp.quote(ThriveTakehome::VERSION.to_s)}/) do
      Dry::CLI.new(ThriveTakehome::CLI::Commands).call(arguments: ['version'])
    end
  end

end
