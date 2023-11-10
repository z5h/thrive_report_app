require 'json'
require 'dry-struct'
require 'dry-validation'
require 'thrive_takehome/types'
require 'thrive_takehome/company'
require 'thrive_takehome/user'
require 'thrive_takehome/schemas'
require 'reporting_error'


module Parser
  def self.parse_companies(json_data)
    parsed_array = JSON.parse(json_data, symbolize_names: true)

    # Unless you find this sentence to be easily and naturally parsable,
    # then you agree with me that unless is a confusing term to start a conditional with.
    # on the other hand ...
    # If you don't find this sentence to be hard to read, then a negative condition after an if is OK.
    if !parsed_array.is_a?(Array)
      raise ThriveTakehome::ReportingError, "Expected a list of companies in companies file. Got: #{parsed_array}"
    end

    validation_results = []
    validation_result = nil
    failed = parsed_array.any? do |company_json|
      validation_result = CompanySchema.call(company_json)
      validation_results << validation_result
      !validation_result.success?
    end

    if failed
      raise ThriveTakehome::ReportingError, "Invalid company data: #{validation_result.errors.to_h}"
    end

    validation_results.map { |company| Company.new(company.to_h) }

  rescue JSON::ParserError => e
    raise ThriveTakehome::ReportingError, "Invalid JSON in company file: #{e.message}"
  end

  def self.parse_users(json_data)
    parsed_array = JSON.parse(json_data, symbolize_names: true)

    if !parsed_array.is_a?(Array)
      raise ThriveTakehome::ReportingError, "Expected a list of users in users file. Got: #{parsed_array}"
    end

    validation_results = []
    validation_result = nil
    failed = parsed_array.any? do |company_json|
      validation_result = UserSchema.call(company_json)
      validation_results << validation_result
      !validation_result.success?
    end

    if failed
      raise ThriveTakehome::ReportingError, "Invalid user data: #{validation_result.errors.to_h}"
    end

    validation_results.map { |company| User.new(company.to_h) }

  rescue JSON::ParserError => e
    raise ThriveTakehome::ReportingError, "Invalid JSON in users file: #{e.message}"
  end
end