# logfmtr
The default ruby logger (`require 'logger'`) outputs in this format:
```
I, [2015-07-01T11:47:45.157173 #29367]  INFO -- : some message here (StandardError)
```
This provides a replacement for the default Logger::Formatter class, and it formats logs in key=value format.

Logs a hash as:
```
{ one: 1, two: 2 } => one=1 two=2
```
Everything else as:
```
=> msg=your message here
```
## Usage
### Example logging error
Errors have their own `.to_s` implementation.
```ruby
require 'logger'
require 'logfmtr'

logger = Logger.new($stdout)
logger.formatter = Logfmtr::LogfmtLogger.new

begin
  raise StandardError.new('some output')
rescue => e
  logger.error e
end

# output
# level=ERROR datetime=2015-07-01 08:29:52 -0500 progname= msg=some output
```
### Example logging error with a custom datetime format
```ruby
require 'logger'
require 'logfmtr'

logger = Logger.new($stdout)
logger.formatter = Logfmtr::LogfmtLogger.new("%Y-%m-%d %H:%M %Z")

begin
  raise StandardError.new('some output')
rescue => e
  logger.error e
end

# output
# level=ERROR datetime=2015-07-01 08:29 CDT progname= msg=some output
```
### Example logging hash
It pulls out hash values into their own key=value pairs in logfmt.
```ruby
require 'logger'
require 'logfmtr'

logger = Logger.new($stdout)
logger.formatter = Logfmtr::LogfmtLogger.new

logger.info({ one: 1, two: 2 })

# output
# level=INFO datetime=2015-07-01 08:29 CDT progname= one=1 two=2
```
### Note about datetime_format
The default datetime_format in Logger::Formatter appears to be `"%Y-%m-%d %H:%M:%S %z"`. When you set your `logger.datetime_format=`, it does not get used by the formatter class. Logger::Formatter appears to have its own default. This gem makes that explicit.
