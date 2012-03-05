require "gmail"
require "date"

module GmailExtractor

  # Controls the extraction
  class EmailExtractor
    attr_accessor :user, :password, :printer, :name

    def initialize(user, password, name, printer)
      @user = user
      @password = password
      @printer = printer
      @name = name
    end

    def extract(label, limit)
      connect
      extract_mails_for label, limit
      disconnect
    end

    private
    def extract_mails_for(label, limit)
      header
      body label, limit
      footer
    end

    def disconnect
      @gmail.logout
    end

    def connect
      @gmail = Gmail.connect(user, password)
      raise "password/username wrong" unless @gmail.logged_in?
    end

    def body(label, limit)
      label = @gmail.label(label)
      printer.label(label, limit)

      mails = 0
      label.emails do |email|
        from = email.from.first.name || @name
        date = DateTime.parse(email.date)
        content = email.body.to_s.force_encoding("UTF-8")

        mail = Email.new(from, date, content)

        printer.email(mail)

        mails += 1
        if limit and mails == limit
          break
        end
      end
    end

    def header
      printer.header
    end

    def footer
      printer.footer
    end
  end

end