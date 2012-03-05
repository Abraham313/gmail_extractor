module GmailExtractor

  class EmailXmlFormatter

    attr_accessor :printer

    def initialize(printer)
      @printer = printer
    end

    def header
      result = "<emails>"

      @printer << result
    end

    def footer
      result = "</emails>"

      @printer << result
      @printer.close
    end

    def email(email)
      result = ""
      result << "<email>"
      result << "<from>#{email.from}</from>"
      result << "<date>#{email.date}</date>"
      result << "<content>#{email.content}</content>"
      result << "</email>"

      @printer << result
    end

    def label(label,limit); end

  end

end