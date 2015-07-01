require 'spec_helper'
require 'logger'
require 'logfmt'
require 'stringio'

describe Logfmtr::LogfmtLogger do
  it "exists" do
    logfmtr = Logfmtr::LogfmtLogger.new
    expect(logfmtr).to be
  end

  it "logs using default datetime format" do
    dt_format = default_datetime_format
    expect { log_error(nil) }.to output("level=ERROR datetime=#{Time.now.strftime(dt_format)} progname= msg=some output\n").to_stdout
  end

  it "logs using custom datetime format" do
    dt_format = custom_datetime_format
    expect { log_error(dt_format) }.to output("level=ERROR datetime=#{Time.now.strftime(dt_format)} progname= msg=some output\n").to_stdout
  end

  it "logs hashes smarter" do
    dt_format = default_datetime_format
    expect { log_hash(dt_format) }.to output("level=INFO datetime=#{Time.now.strftime(dt_format)} progname= one=1 two=2\n").to_stdout
  end

  it "logs hashes in logfmt format" do
    dt_format = default_datetime_format

    output = log_to_buffer do |logger|
      logger.formatter = Logfmtr::LogfmtLogger.new(dt_format)
      logHash = { :foo => "bar", :baz => "hello world" }
      logger.info logHash
    end

    expectedHash = {"level" => "INFO", "foo" => "bar", "baz" => "hello world"}
    actualHash = Logfmt.parse output
    expect(actualHash).to include(expectedHash)
  end
end

def custom_datetime_format
  "%Y-%m-%d %H:%M %z"
end

def default_datetime_format
  "%Y-%m-%d %H:%M:%S %z"
end

def log_to_buffer
  buffer = StringIO.new
  logger = Logger.new buffer
  yield logger
  buffer.string
end

def log_error(datetime_format)
  begin
    logger = logger_init(datetime_format)
    raise StandardError.new('some output')
  rescue => e
    logger.error e
  end
end

def log_hash(datetime_format)
  logger = logger_init(datetime_format)
  logger.info ({ one: 1, two: 2 })
end

def logger_init(datetime_format)
  logger = Logger.new($stdout)
  logger.formatter = Logfmtr::LogfmtLogger.new(datetime_format)
  logger
end
