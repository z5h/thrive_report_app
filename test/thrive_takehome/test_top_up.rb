require 'test_helper'
require 'thrive_takehome/top_up'
require 'thrive_takehome/user'
require 'thrive_takehome/company'

class TestTopUp < Minitest::Test

  def setup
    @company =  Company.new(name: 'name', id: 1 ,top_up: 20, email_status: true)

    @user = User.new(
      id: 33,
      first_name: "Ned",
      last_name: "Nederson",
      email: "ned.nederson@test.com",
      company_id: 1,
      email_status: true,
      active_status: true,
      tokens: 3
    )

  end

  def test_new
    top_up = TopUp.new(user: @user, company: @company)
    assert_equal @user.id, top_up.user.id
    assert_equal @user.first_name, top_up.user.first_name
    assert_equal @user.last_name, top_up.user.last_name
    assert_equal @company.id, top_up.company.id

    assert_equal top_up.new_token_balance, 3 + 20
  end
end