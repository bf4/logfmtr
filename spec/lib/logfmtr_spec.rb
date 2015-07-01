require 'spec_helper'
require 'logger'

describe Logfmtr::LogfmtLogger do
  it "exists" do
    logfmtr = Logfmtr::LogfmtLogger.new
    expect(logfmtr).not_to be_nil
  end

  it "logs using default datetime format" do
    expect { log(default_datetime_format) }.to output("level=ERROR datetime=#{Time.now.strftime(default_datetime_format)} progname= msg=some output\n").to_stdout
  end

  it "logs using custom datetime format" do
    expect { log(custom_datetime_format) }.to output("level=ERROR datetime=#{Time.now.strftime(custom_datetime_format)} progname= msg=some output\n").to_stdout
  end
end

def custom_datetime_format
  "%Y-%m-%d %H:%M %z"
end

def default_datetime_format
  "%Y-%m-%d %H:%M:%S %z"
end

def log(datetime_format)
  begin
    logger = Logger.new($stdout)
    logger.level = Logger::DEBUG
    logger.formatter = Logfmtr::LogfmtLogger.new(datetime_format)
    raise StandardError.new('some output')
  rescue => e
    logger.error e
  end
end
