require 'spec_helper'

describe Billing::PaypalController do
  it_behaves_like "validating pay_system state", :result, "item_number"
  it_behaves_like 'has success and fail responders'

  describe "#result" do

  end
end
