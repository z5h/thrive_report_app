require 'test_helper'
require 'thrive_takehome/report'

class TestReport < Minitest::Test
  def setup
    @company_json_text = File.read('test/fixtures/companies.json')
    @user_json_text = File.read('test/fixtures/users.json')
    @expected_output = File.read('test/fixtures/example_output.txt')
  end

  def test_report
    r = Report.report(@company_json_text, @user_json_text)
    assert_equal @expected_output, r
  end

end
