# logfmtr

## Usage
  ```
  require 'logger'
  require 'logfmtr'

  logger = Logger.new($stdout)
  logger.formatter = Logfmtr::LogfmtLogger.new
  ```

### Example
  ```
  begin
    raise StandardError.new('some output')
  rescue => e
    logger.info e
  end

  # output
  # level=INFO datetime=2015-07-01 08:29:52 -0500 progname= msg=some output
  ```
