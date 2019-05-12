# frozen_string_literal: true

require 'rails_helper'
require 'clockwork/test'

describe Clockwork do
  before do
    allow(WithdrawalsWorker).to receive(:perform_async).and_return('WithdrawalsID')
    allow(UpdateCoursesWorker).to receive(:perform_async).and_return('UpdateCoursesID')
    allow(RefreshProxyListWorker).to receive(:perform_async).and_return('RefreshProxyListID')
  end

  after { Clockwork::Test.clear! }

  %w[Withdrawals UpdateCourses RefreshProxyList].each do |job|
    it "runs the job #{job} once" do
      Clockwork::Test.run(max_ticks: 1)

      expect(Clockwork::Test).to be_ran_job(job)
      expect(Clockwork::Test.times_run(job)).to eq 1
      expect(Clockwork::Test.block_for(job).call).to eq("#{job}ID")
    end

    it "runs the job #{job} every hour" do
      start_time = Time.new(2018, 1, 2, 1, 0, 0)
      end_time = Time.new(2018, 1, 3, 1, 0, 0)

      Clockwork::Test.run(start_time: start_time, end_time: end_time, tick_speed: 1.hour)

      expect(Clockwork::Test.times_run(job)).to eq(24)
    end
  end

  it 'executes correct Sidekiq worker for Withdrawals task' do
    Clockwork::Test.run(max_ticks: 1)
    Clockwork::Test.block_for('Withdrawals').call
    expect(WithdrawalsWorker).to have_received(:perform_async).once
  end

  it 'executes correct Sidekiq worker for UpdateCourses task' do
    Clockwork::Test.run(max_ticks: 1)
    Clockwork::Test.block_for('UpdateCourses').call
    expect(UpdateCoursesWorker).to have_received(:perform_async).once
  end

  it 'executes correct Sidekiq worker for RefreshProxyList task' do
    Clockwork::Test.run(max_ticks: 1)
    Clockwork::Test.block_for('RefreshProxyList').call
    expect(RefreshProxyListWorker).to have_received(:perform_async).once
  end
end
