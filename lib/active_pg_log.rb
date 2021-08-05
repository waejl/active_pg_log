# frozen_string_literal: true

require 'active_record'
module ActivePgLog
  VERSION = '0.1.1'
end

require 'active_pg_log/active_pg_log_table'
require 'active_pg_log/prepare'
require 'active_pg_log/trigger'
require 'active_pg_log/active_log'
