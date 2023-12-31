# frozen_string_literal: true

require 'bundler/setup'
require 'ts_trans'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  require File.expand_path('../spec/dummy/config/environment.rb', __dir__)
  ENV['RAILS_ROOT'] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

  require 'rspec/rails'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
