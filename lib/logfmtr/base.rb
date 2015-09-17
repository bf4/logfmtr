module Logfmtr
  class LogfmtLogger
    def initialize(datetime_format=nil)
      @datetime_format = datetime_format || "%Y-%m-%d %H:%M:%S %z"
    end

    def call(severity, datetime, progname, msg)
      if msg.is_a? Hash
        msg_str = logfmtify_hash(msg)
      else
        msg = add_quotes(escape_newlines(msg))
        msg_str = %Q[msg=#{msg}]
      end

      %Q[level=#{severity} datetime="#{datetime.strftime(@datetime_format)}" progname=#{progname} #{msg_str}\n]
    end

    private

    def logfmtify_hash(message)
      message.collect do |key, value|
        value = add_quotes(escape_newlines(value))
        %Q[#{key}=#{value}]
      end.join(' ')
    end

    def add_quotes(message)
      if needs_quotes(message)
        %Q["#{message}"]
      else
        %Q[#{message}]
      end
    end

    def needs_quotes(message)
      if message.to_s =~ /[^a-zA-Z0-9\-\.]/
        true
      else
        false
      end
    end

    def escape_newlines(message)
      message.to_s.gsub(/\n/, "\\n")
    end
  end
end