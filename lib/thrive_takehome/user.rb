require 'dry-struct'
require 'thrive_takehome/types'

class User < Dry::Struct
  attribute :id, Types::Integer
  attribute :first_name, Types::String
  attribute :last_name, Types::String
  attribute :email, Types::Email
  attribute :company_id, Types::Integer
  attribute :email_status, Types::Bool
  attribute :active_status, Types::Bool
  attribute :tokens, Types::NaturalNumber
end