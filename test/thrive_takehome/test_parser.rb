require 'test_helper'
require 'thrive_takehome/parser'

class TestParser < Minitest::Test
  def setup
    @company_json_text = File.read('test/fixtures/companies.json')
    @user_json_text = File.read('test/fixtures/users.json')
  end

  def test_parse_companies
    companies = Parser.parse_companies(@company_json_text)
    assert_equal 6, companies.length
    assert_equal 1, companies[0].id
    assert_equal 6, companies[5].id
  end

  def test_parse_users
    users = Parser.parse_users(@user_json_text)
    assert_equal 35, users.length
    assert_equal 1, users[0].id
    assert_equal 34, users[34].id
  end
end