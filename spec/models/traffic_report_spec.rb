require 'spec_helper'

describe TrafficReport do
  let(:params) { Hash[] }
  subject { described_class.new(params) }

  describe "report building" do
    before do
      report_ar_relation = mock()
      report_ar_relation.expects(:where).returns([])
      TrafficReport.any_instance.expects(:build_report).returns(report_ar_relation)
    end

    it "builds report on result call" do
      expect(subject.result).not_to be_nil
    end
  end

  context "params on initialization passed" do
    let(:params) { {
      date_from: "01-10-2013",
      date_to: "31-10-2013"
    } }

    it "date_from returns date from params" do
      expect(subject.date_from).to eq "01-10-2013"
    end

    it "date_to returns date from params" do
      expect(subject.date_to).to eq "31-10-2013"
    end
  end

  context "no params passed" do
    it "date from equals beginning of month" do
      expect(subject.date_from).to eq Date.current.beginning_of_month
    end

    it "date to equals end of month" do
      expect(subject.date_to).to eq Date.current.end_of_month
    end
  end

end
