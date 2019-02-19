# frozen_string_literal: true

require 'clockwork/test'

describe Clockwork do
  after(:each) { Clockwork::Test.clear! }

  %w[Withdrawals UpdateCourses RefreshProxyList].each do |job|
    it "runs the job #{job} once" do
      Clockwork::Test.run(max_ticks: 1)

      expect(Clockwork::Test.ran_job?(job)).to be_truthy
      expect(Clockwork::Test.times_run(job)).to eq 1
      expect(Clockwork::Test.block_for(job).call).to be_kind_of(String)
    end

    it "runs the job #{job} every hour" do
      start_time = Time.new(2018, 1, 2, 1, 0, 0)
      end_time = Time.new(2018, 1, 3, 1, 0, 0)

      Clockwork::Test.run(start_time: start_time, end_time: end_time, tick_speed: 1.hour)

      expect(Clockwork::Test.times_run(job)).to eq(24)
    end
  end
end
