# frozen_string_literal: true

require 'bundler/setup'
require 'active_pg_log'
require 'active_record'
require 'pg'

begin
  ActiveRecord::Base.establish_connection({
                                            adapter: 'postgresql',
                                            database: 'active_pg_log',
                                            min_messages: 'warning',
                                            host: 'localhost',
                                            username: 'postgres'
                                          })
  connection = ActiveRecord::Base.connection
  connection.execute('SELECT 1')
  connection.execute('create table if not exists my_object_tests(
    id serial not null,
    name varchar(255)
  );')
  # connection.execute('create database active_pg_log;')
  # connection.reconect!({
  #                        adapter: 'postgresql',
  #                        database: 'active_pg_log',
  #                        min_messages: 'warning',
  #                        host: 'localhost',
  #                        username: 'postgres',
  #                        password: 'password'
  #                      })
rescue StandardError => e
  puts '-' * 80
  puts 'Unable to connect to database.  Please run:'
  puts
  puts '    createdb pg_audit_log_test'
  puts '-' * 80
  raise e
end

ActiveRecord::Base.default_timezone = :local

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
