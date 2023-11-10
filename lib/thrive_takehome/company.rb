require 'dry-struct'
require 'thrive_takehome/types'

class Company < Dry::Struct
  attribute :id, Types::Integer
  attribute :name, Types::String
  attribute :top_up, Types::NaturalNumber
  attribute :email_status, Types::Bool
end