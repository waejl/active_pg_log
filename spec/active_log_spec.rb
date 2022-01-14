# frozen_string_literal: true

RSpec.describe ActivePgLog::ActiveLog do
  it 'respond to pg_logs' do
    expect(subject.instance_methods).to include(:pg_logs)
  end

  it 'respond to disable_log_ddl_trigger' do
    expect(subject.instance_methods).to include(:disable_log_ddl_trigger)
  end

  it 'respond to create_log_ddl_trigger' do
    expect(subject).to respond_to(:create_log_ddl_trigger)
  end
end
