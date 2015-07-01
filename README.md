# logfmtr

A replacement for Logger::Formatter class that formats logs in key=value format. Logs a hash as:
```
{ one: 1, two: 2 } => one=1 two=2
```
Everything else as:
```
=> msg=your message here
```
## Usage
### Example logging error
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
