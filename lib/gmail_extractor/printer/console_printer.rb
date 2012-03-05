module GmailExtractor

  class ConsolePrinter

    def initialize(printer = nil)
      @printer = printer
    end

    def << (string)
      puts string
      @printer << string if printer?
    end

    def close
      @printer.close if printer?
    end

    private
    def printer?
      @printer
    end

  end

end