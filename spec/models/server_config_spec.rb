require 'spec_helper'

describe ServerConfig do
  subject { described_class.new }

  it 'addes line to buffer' do
    subject.append_line "new_line"
    expect(subject.config_lines).to include 'new_line'
  end

  it 'converts to text' do
    subject.append_line 'first'
    subject.append_line 'second'
    expect(subject.to_text).to include 'first', 'second'
  end
end
