require 'thrive_takehome/parser'
require 'thrive_takehome/top_up'

require 'erb'
=begin
  Criteria for the output file.

  Any user that belongs to a company in the companies file and is active
  needs to get a token top up of the specified amount in the companies top up
  field.

  If the users company email status is true indicate in the output that the
  user was sent an email ( don't actually send any emails).
  However, if the user has an email status of false, don't send the email
  regardless of the company's email status.

  Companies should be ordered by company id.
  Users should be ordered alphabetically by last name.
  Any user that belongs to a company in the companies file and is active needs to get a token top up of the specified amount in the companies top up field.

=end

class Report

  def self.render(template, b)
    template.result(b)
  end

  def self.user_info(top_up)
    user = top_up.user
    "#{user.last_name}, #{user.first_name}, #{user.email}"
  end

  def self.company_total_lines(company, top_ups)
    total = top_ups.map(&:top_up_amount).sum
    "Total amount of top ups for #{company.name}: #{total}"
  end

  TOP_UP_DETAIL = ERB.new(
    %{|\t\t<%= user_info(top_up) %>
      |\t\t  Previous Token Balance, <%= top_up.prev_token_balance %>
      |\t\t  New Token Balance <%= top_up.new_token_balance %>}
      .gsub(/^\s*\|/, ''), trim_mode: '-', eoutvar: '_erbout_top_up_detail')

  COMPANY_REPORT = ERB.new(
    %{|\tCompany Id: <%= company.id %>
      |\tCompany Name: <%= company.name %>
      |\tUsers Emailed:
      |<% top_ups.dup.keep_if(&:send_email?).each do |top_up| -%>
      |<%= render(TOP_UP_DETAIL, binding) %>
      |<% end -%>
      |\tUsers Not Emailed:
      |<% top_ups.dup.reject(&:send_email?).each do |top_up| -%>
      |<%= render(TOP_UP_DETAIL, binding) %>
      |<% end -%>
      |\t\t<%= company_total_lines(company, top_ups) %>}
      .gsub(/^\s*\|/, ''), trim_mode: '-', eoutvar: '_erbout_company_report')



  def self.report(companies_data, users_data)
    companies = Parser.parse_companies(companies_data)
                      .sort_by(&:id)

    users = Parser.parse_users(users_data)

    all_top_ups =
      companies
        .product(users)
        .keep_if { |company, user| company.id == user.company_id }
        .map { |company, user| TopUp.new(user: user, company: company) }
        .keep_if(&:apply?)
        .sort_by { |t| [t.user.last_name, t.user.first_name] }

    company_reports =
      companies
        .keep_if { |company| all_top_ups.any? { |top_up| top_up.company.id == company.id } }
        .map { |company|
          # note that company and top_ups are captured in the binding, and expected in the template
          top_ups = all_top_ups.dup.keep_if { |top_up| top_up.company.id == company.id }

          # not necessary to set these, bit it's explicit
          b = binding
          b.local_variable_set(:company, company)
          b.local_variable_set(:top_ups, top_ups)
          render(COMPANY_REPORT, b)
        }

    "\n" + company_reports.join("\n\n") + "\n"
  end
end