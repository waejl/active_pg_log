# frozen_string_literal: true

RSpec.describe ActivePgLog do
  it 'has a version number' do
    expect(ActivePgLog::VERSION).not_to be nil
  end

  it 'trigger has required' do
    expect(ActivePgLog::ActiveTrigger).to_not be_nil
  end

  it 'active_log has required' do
    expect(ActivePgLog::ActiveLog).to_not be_nil
  end
end
