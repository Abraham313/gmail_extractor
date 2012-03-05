require "csv"

module GmailExtractor

  class EmailCsvFormatter

    attr_accessor :printer

    def initialize(printer)
      @printer = printer
    end

    def header;  end

    def footer;  end

    def email(email)
      @printer << [email.date, email.from, email.content].to_csv
    end

    def label(label,limit); end

  end

end