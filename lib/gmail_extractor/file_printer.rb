module GmailExtractor

  class FilePrinter

    def initialize(output_file)
      @output_file = File.open(output_file,"w:utf-8")
      @output_file.sync = true
    end

    def << (string)
      @output_file << string
    end

    def close
      @output_file.close
    end
  end

end