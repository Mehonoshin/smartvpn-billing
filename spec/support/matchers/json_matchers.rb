RSpec::Matchers.define :be_json do |expected|
  match do |actual|
    actual.headers['Content-Type'].include?("application/json")
  end
end
