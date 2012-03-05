# encoding: utf-8
require "gmail_extractor/version"
require "gmail_extractor/email"
require "gmail_extractor/email_extractor"
require "gmail_extractor/console_printer"
require "gmail_extractor/file_printer"
require "gmail_extractor/email_csv_formatter"
require "gmail_extractor/email_xml_formatter"
require "gmail_extractor/email_html_formatter"
require "gmail_extractor/email_progressbar"

module GmailExtractor

  def self.execute
    # Reading from command line
    require "optparse"
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: get_mails.rb [options]"
      opts.on("-u","--username USERNAME","Set gmail USERNAME") do |username|
        options[:username] = username
      end
      opts.on("-p","--password PASSWORD","Set gmail PASSWORD") do |password|
        options[:password] = password
      end
      opts.on("-n","--name NAME","Set own NAME; defaults to Self if not given") do |name|
        options[:name] = name || "Self"
      end
      opts.on("-m","--mailbox MAILBOX","Set MAILBOX from where the mails are fetched. Label names can be used too!") do |mailbox|
        options[:mailbox] = mailbox
      end
      opts.on("-l","--limit LIMIT","Set limit LIMIT to how many emails are fetched; defaults to all if not given") do |limit|
        options[:limit] = limit.to_i
      end
      opts.on("-o","--output TYPE","Set output TYPE to xml, csv or html. defaults to csv") do |output|
        options[:output] = output || "csv"
      end
      opts.on("-f","--file FILE","Set output FILE. if not present, only output to STDOUT") do |file|
        options[:file] = file
      end
      opts.on("-p","--progressbar","Show progressbar on STDOUT") do
        options[:progressbar] = true
      end
      opts.on("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end.parse!

    # set printer
    file = options[:file]
    if file
      printer = ConsolePrinter.new(FilePrinter.new(file))
    else
      printer = ConsolePrinter.new
    end

    # set correct formatter
    output = options[:output].downcase
    if output == "xml"
      formatter = EmailXmlFormatter.new(printer)
    elsif output == "csv"
      formatter = EmailCsvFormatter.new(printer)
    elsif output == "html"
      formatter = EmailHtmlFormatter.new(printer)
    else
      raise "Internal error - no output option given"
    end

    # handle progressbar
    if options[:progressbar]
      formatter = EmailProgressbar.new(formatter)
    end

    # Asking missing values
    require "highline/import"
    user = options[:username] || ask("Enter user: ")
    password = options[:password] || ask("Enter password: ") { |q| q.echo = false }
    name = options[:name]
    extractor = EmailExtractor.new(user,password,name,formatter)

    # Ask missing values and extract
    label = options[:mailbox] || ask("Enter mailbox/label: ")
    limit = options[:limit]
    extractor.extract(label, limit)
  end

end