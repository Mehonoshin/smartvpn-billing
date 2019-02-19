# frozen_string_literal: true

require 'rails_helper'

describe UpdateCoursesWorker do
  subject { described_class.new }

  context '#perform' do
    before { allow(Currencies::Course).to receive(:update_courses) }

    it 'executes Currencies::Course.update_courses once with correct params' do
      subject.perform
      expect(Currencies::Course).to have_received(:update_courses).once
    end
  end
end
