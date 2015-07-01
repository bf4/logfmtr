module Logfmtr
  class LogfmtLogger
    def initialize(datetime_format=nil)
      @datetime_format = datetime_format || "%Y-%m-%d %H:%M:%S %z"
    end

    def call(severity, datetime, progname, msg)
      if msg.is_a? Hash
        msg_str = logfmtify_hash(msg)
      else
        msg_str = "msg=#{msg}"
      end

      "level=#{severity} datetime=#{datetime.strftime(@datetime_format)} progname=#{progname} #{msg_str}\n"
    end

    private

    def logfmtify_hash(message)
      message.collect do |key, value|
        "#{key}=#{value}"
      end.join(' ')
    end
  end
end