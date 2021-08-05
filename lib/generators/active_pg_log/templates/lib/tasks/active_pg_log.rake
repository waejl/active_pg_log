# frozen_string_literal: true

namespace :active_pg_log do
  desc 'Install table on database'
  task install: :environment do
    ActivePgLog::Configuration.setup
  end

  desc 'Remove table and function of the database'
  task uninstall: :environment do
    ActivePgLog::Configuration.destroy
  end
end
