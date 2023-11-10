require 'test_helper'
require 'thrive_takehome/company'

class TestCompany < Minitest::Test

  def test_new_with_valid_parameters
    company =  Company.new(name: 'name', id: 1 ,top_up: 20, email_status: true)
    assert_equal 'name', company.name
    assert_equal 1, company.id
    assert_equal 20, company.top_up
    assert_equal true, company.email_status
  end

  def test_new_with_invalid_top_up_value
    e = assert_raises Dry::Struct::Error do
      Company.new(name: 'name', id: 1 ,top_up: -20, email_status: true)
    end
    # message should complain about top_up
    assert e.message['top_up']
  end

  def test_new_with_missing_parameters
    e = assert_raises Dry::Struct::Error do
      Company.new(name: 'name', id: 1 ,top_up: 20)
    end

    assert e.message['email_status is missing']
  end
end