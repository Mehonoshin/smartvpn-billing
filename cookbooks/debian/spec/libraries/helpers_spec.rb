require 'spec_helper'
require 'helpers'

describe Chef::Debian::Helpers do

  describe '.codename' do
    context 'with lsb attributes' do
      let(:lsb_codename) { 'banana' }
      let(:node) { Hash['lsb' => { 'codename' => lsb_codename }, 'platform_version' => '5.0.1'] }
      subject { described_class.codename(node) }

      it { should eq lsb_codename }
    end

    context 'without lsb attributes' do
      let(:codename) { 'pineapple' }
      let(:platform_version) { '1.2.3' }
      let(:node) { Hash['platform_version' => platform_version] }

      it 'should use .codename_for_platform_version' do
        described_class.should_receive(:codename_for_platform_version).with(platform_version).and_return(codename)
        expect(described_class.codename(node)).to eq codename
      end
    end
  end

  describe '.codename_for_platform_version' do
    versions = {
      '6.0.7'   => 'squeeze',
      '7.0'     => 'wheezy',
      '7.1'     => 'wheezy',
      '8.0'     => 'stable',
      'unknown' => 'stable',
    }
    versions.each do |version, codename|
      context "with #{version}" do
        subject { described_class.codename_for_platform_version(version) }
        it { should eq codename }
      end
    end
  end

  describe '.backports_mirror' do
    let(:default_mirror) {}
    let(:backports_mirror) {}
    let(:platform_version) { '1.2.3' }
    let(:node) do
      {
        'debian' => {
          'mirror'           => default_mirror,
          'backports_mirror' => backports_mirror
        },
        'platform_version' => platform_version
      }
    end
    subject { described_class.backports_mirror(node) }

    context 'with specified backports mirror' do
      let(:backports_mirror) { 'http://foo/' }

      it { should eq backports_mirror }
    end

    context 'without specified backports mirror' do
      ['7.0', '8.2'].each do |version|
        context "in #{version}" do
          let(:platform_version) { version }
          it { should be_nil }
        end
      end

      context 'in 6.0' do
        let(:platform_version) { '6.0.7' }

        context 'with default mirror ending with /debian' do
          let(:default_mirror) { 'http://mirror/debian' }
          it { should eq "#{default_mirror}-backports" }
        end

        context 'with default mirror not ending with /debian' do
          let(:default_mirror) { 'http://mirror/custom' }
          it { should eq 'http://backports.debian.org/debian-backports' }
        end
      end
    end
  end

end
