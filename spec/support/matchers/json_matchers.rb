# frozen_string_literal: true

RSpec::Matchers.define :be_json do |_expected|
  match do |actual|
    actual.headers['Content-Type'].include?('application/json')
  end
end
