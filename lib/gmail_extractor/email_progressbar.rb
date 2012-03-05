require "progressbar"

module GmailExtractor

  # Simple printer proxy to enable tracking the progress with a progress bar transparently.
  class EmailProgressbar

    attr_accessor :printer

    def initialize(printer)
      @printer = printer
    end

    def header
      printer.header
    end

    def footer
      printer.footer
      @progress_bar.finish
    end

    def email(email)
      printer.email(email)
      @progress_bar.inc
    end

    def label(label,limit)
      printer.label(label,limit)
      total_count = limit || label.count
      @progress_bar = ProgressBar.new("emails",total_count)
    end

  end

end