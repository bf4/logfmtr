# logfmtr

## Usage

  require 'logger'
  require 'logfmtr'

  $logger = Logger.new(STDOUT)
  $logger.formatter = Logfmtr.new

  # Example
  ```
  begin
    raise NoMethodError.new('omg wtf')
  rescue => e
    $logger.info e
  end

  # output
  # level=INFO datetime=2015-07-01 08:29:52 -0500 progname= msg=omg wtf
  ```
