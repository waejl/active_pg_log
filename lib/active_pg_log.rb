# frozen_string_literal: true

module ActivePgLog
  VERSION = '0.1.3'
end

require 'active_record'
require 'active_pg_log/active_pg_log_table'
require 'active_pg_log/prepare'
require 'active_pg_log/active_trigger'
require 'active_pg_log/active_log'
