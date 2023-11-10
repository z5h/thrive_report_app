require 'test_helper'
require 'thrive_takehome/types'

class TestTypes < Minitest::Test

  def test_natural_number
    assert_equal 0, Types::NaturalNumber[0]
    assert_equal 1, Types::NaturalNumber[1]
    assert_raises Dry::Types::ConstraintError do
      Types::NaturalNumber[-1]
    end
  end

  def test_email
    assert_equal 'name@place.com', Types::Email['name@place.com']

    assert_raises Dry::Types::ConstraintError do
      Types::Email['name@place']
    end

    assert_raises Dry::Types::ConstraintError do
      Types::Email['name']
    end

    assert_raises Dry::Types::ConstraintError do
      Types::Email['name@name@place']
    end
  end
end