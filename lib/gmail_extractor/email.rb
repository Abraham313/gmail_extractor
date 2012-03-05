module GmailExtractor

  class Email
    attr_accessor :from, :content, :date

    def initialize(from, date, content)
      @from = from
      @date = date
      @content = content
    end
  end

end