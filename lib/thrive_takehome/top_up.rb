require 'thrive_takehome/user'
require 'thrive_takehome/company'
require 'dry-struct'

class TopUp < Dry::Struct

  attribute :user do
    attributes_from User
  end

  attribute :company do
    attributes_from Company
  end

  def apply?
    user.active_status
  end

  def send_email?
    company.email_status && user.email_status
  end

  def prev_token_balance
    user.tokens
  end

  def top_up_amount
    company.top_up
  end

  def new_token_balance
    prev_token_balance + top_up_amount
  end
end