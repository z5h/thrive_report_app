require 'json'
require 'dry-struct'
require 'dry-validation'
require 'thrive_takehome/types'

UserSchema = Dry::Schema.JSON do
  required(:id).value(:integer)
  required(:first_name).value(:string)
  required(:last_name).value(:string)
  required(:email).value(Types::Email)
  required(:company_id).value(:integer)
  required(:email_status).value(:bool)
  required(:active_status).value(:bool)
  required(:tokens).value(Types::NaturalNumber)
end

CompanySchema = Dry::Schema.JSON do
  required(:id).value(:integer)
  required(:name).value(:string)
  required(:top_up).value(Types::NaturalNumber)
  required(:email_status).value(:bool)
end