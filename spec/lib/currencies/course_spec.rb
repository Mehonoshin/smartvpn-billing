require 'spec_helper'

describe Currencies::Course do
  let(:online_course) { 1.5 }
  let(:redis) { Redis.new }

  before do
    described_class.stubs(:fetch_course_from_web).returns(online_course)
  end

  describe "updating all courses" do
    subject { described_class }

    before do
      redis.flushall
      subject.update_courses
    end

    it "sets course for eur" do
      expect(redis.get("smartvpn:eur_usd")).not_to be_nil
    end

    it "sets course for usd" do
      expect(redis.get("smartvpn:rub_usd")).not_to be_nil
    end

    it "sets updated_at value" do
      expect(redis.get("smartvpn:courses:updated_at")).not_to be_nil
    end
  end

  describe "fetching course" do
    subject { described_class.new("eur", "usd") }

    before { redis.flushall }

    context 'currency from equal to currency to' do
      subject { described_class.new("usd", "usd") }

      it 'returns 1' do
        expect(subject.get).to eq 1
      end
    end

    context "redis es empty" do
      it 'fetching from web' do
        subject.expects(:parse_from_web).once
        subject.get
      end

      it 'returns real course' do
        expect(subject.get).not_to be_nil
      end
    end

    context "record exists in redis" do
      let(:cached_course) { "2" }
      before do
        redis.set("smartvpn:eur_usd", cached_course)
        redis.set("smartvpn:courses:updated_at", Time.current)
      end

      it 'returns update date' do
        expect(described_class.updated_at).not_to be_nil
      end

      it 'loading record from redis' do
        subject.expects(:fetch_from_redis)
        subject.get
      end

      it 'returns course from redis' do
        expect(subject.get).to eq cached_course
      end

      it 'does not fetch web' do
        subject.expects(:parse_from_web).never
        subject.get
      end
    end
  end
end
