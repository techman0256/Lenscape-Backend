ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

ENV['HOST'] ||= '127.0.0.1' # Default host
ENV['PORT'] ||= '4000'    # Default port