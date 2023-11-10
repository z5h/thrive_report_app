require 'test_helper'
require 'thrive_takehome/schemas'

class TestSchemas < Minitest::Test
  def setup
    @company_hash =
      {
        "id": 1,
        "name": "Red Horse Inc.",
        "top_up": 55,
        "email_status": true
      }
    @user_hash =
      {
        "id": 33,
        "first_name": "Ned",
        "last_name": "Nederson",
        "email": "ned.nederson@test.com",
        "company_id": 3,
        "email_status": true,
        "active_status": true,
        "tokens": 3
      }

    @bad_user_hash = @user_hash.merge({ "id": true })

    @bad_company_hash = @company_hash.merge({ "id": true })
  end

  def test_company_schema
    assert CompanySchema.call(@company_hash).success?

    assert !CompanySchema.call(@bad_company_hash).success?
  end

  def test_user_schema
    assert UserSchema.call(@user_hash).success?

    assert !UserSchema.call(@bad_user_hash).success?
  end
end