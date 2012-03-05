module GmailExtractor

  # Prints the output as html
  class EmailHtmlFormatter

    attr_accessor :printer

    def initialize(printer)
      @printer = printer
    end

    def header
      result = "<!doctype html><html><head><title>E-Mails</title><meta charset='utf-8'></head><body>"

      @printer << result
    end

    def footer
      result = "</body></html>"

      @printer << result
      @printer.close
    end

    def email(email)
      result = ""
      result << "<div class='email'>"
      result << "<div class='from'>#{email.from}</div>"
      result << "<div class='date'>#{email.date}</div>"
      result << "<div class='content'>#{email.content}</div>"
      result << "</div>"

      @printer << result
    end

    def label(label,limit)
      result = ""
      result << "<div class='label'>"
      result << "<div class='name'>#{label.name}</div>"
      result << "<div class='count'>#{label.count}</div>"
      result << "</div>"

      @printer << result
    end

  end

end