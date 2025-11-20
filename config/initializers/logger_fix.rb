# Fix for Rails 6.0 + Ruby 3.1+ Logger constant issue
# This ensures Logger is available before ActiveSupport tries to reference it
require 'logger' unless defined?(Logger)
