# frozen_string_literal: true

class MyObjectTest < ActiveRecord::Base
  include ActivePgLog::ActiveLog
end

RSpec.describe ActivePgLogTable do
  before do
    MyObjectTest.create(name: 'Test Object')
  end

  it 'on create test object Log Table is incremented' do
    expect(subject).to count(1)
  end
end
