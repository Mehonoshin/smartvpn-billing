require 'spec_helper'

describe ApplicationHelper do
  describe "human_date" do
    let(:date) { DateTime.new(2001, 2, 3, 4, 5, 6) }

    context "date is nil" do
      subject { helper.human_date(nil) }

      it "returns nil" do
        expect(subject).to eq nil
      end
    end

    context "default behaviour" do
      subject { helper.human_date(date) }

      it "returns date with time" do
        expect(subject).to include "04:05"
      end
    end

    context "time:false argument passed" do
      subject { helper.human_date(date, time: false) }

      it "returns date without time" do
        expect(subject).not_to include "04:05"
      end
    end
  end
end
