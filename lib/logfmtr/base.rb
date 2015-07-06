module Logfmtr
  class LogfmtLogger
    def initialize(datetime_format=nil)
      @datetime_format = datetime_format || "%Y-%m-%d %H:%M:%S %z"
    end

    def call(severity, datetime, progname, msg)
      if msg.is_a? Hash
        msg_str = logfmtify_hash(msg)
      else
        msg_str = %Q[msg=#{add_quotes(msg)}]
      end

      %Q[level=#{severity} datetime="#{datetime.strftime(@datetime_format)}" progname=#{progname} #{msg_str}\n]
    end

    private

    def logfmtify_hash(message)
      message.collect do |key, value|
        %Q[#{key}=#{add_quotes(value)}]
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
      if message.to_s =~ /\s/
        true
      else
        false
      end
    end
  end
end