# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

JWT_SECRET = ENV['JWT_SECRET'] || 'fallback_secret_key'