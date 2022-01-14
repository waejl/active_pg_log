# frozen_string_literal: true

require 'active_pg_log'

class MyObjectTest < ActiveRecord::Base
  include ActivePgLog::ActiveLog
end

RSpec.describe MyObjectTest do
  context 'Include lib' do
    it 'respond_to pg_logs' do
      expect(subject).to respond_to(:pg_logs)
    end

    it 'respond_to disable_log_ddl_trigger' do
      expect(subject).to respond_to(:disable_log_ddl_trigger)
    end
  end
end
