module ThriveTakehome
  class ReportingError < StandardError
    def initialize(msg="Error generating report")
      super
    end
  end
end
