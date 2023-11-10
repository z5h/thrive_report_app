require 'dry-types'

module Types

  # Dry docs say to call this, but IDE's might not like it.
  # include Dry.Types()
  # The following is the same as above, but IDE's like it.
  include Dry::Types::Module.new(Dry::Types.container, default: Dry::Types::Undefined)


  #noinspection RubyConstantNamingConvention
  Email = String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)

  #noinspection RubyConstantNamingConvention
  NaturalNumber = Integer.constrained(gteq: 0)
end