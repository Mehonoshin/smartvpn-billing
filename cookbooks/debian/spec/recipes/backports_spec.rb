require 'spec_helper'

describe 'debian::backports' do
  context 'on Squeeze' do
    context 'with default mirrors' do
      subject do
        debian_runner('6.0.5').converge 'debian::backports'
      end

      it { should add_backports_source 'http://http.debian.net/debian-backports' }
    end

    context 'with specified default mirror' do
      context 'ending with /debian' do
        let(:chef_run) do
          debian_runner('6.0.5') do |node|
            node.set['debian']['mirror'] = 'http://example.com/debian'
          end.converge 'debian::backports'
        end

        it 'uses it with /debian-backpors suffix' do
          expect(chef_run).to add_backports_source 'http://example.com/debian-backports'
        end
      end

      context 'not ending with /debian' do
        let(:chef_run) do
          debian_runner('6.0.5') do |node|
            node.set['debian']['mirror'] = 'http://example.com/debian-mirror'
          end.converge 'debian::backports'
        end

        it 'uses backports.debian.org' do
          expect(chef_run).to add_backports_source 'http://backports.debian.org/debian-backports'
        end
      end
    end

    context 'with specified backports mirror' do
      let(:chef_run) do
        debian_runner('6.0.5') do |node|
          node.set['debian']['backports_mirror'] = 'http://example.com/backports-mirror'
          node.set['debian']['mirror'] = 'http://example.com/default-mirror'
        end.converge 'debian::backports'
      end

      it 'uses it' do
        expect(chef_run).to add_backports_source 'http://example.com/backports-mirror'
      end
    end
  end

  context 'on Wheezy' do
    context 'with default mirrors' do
      subject do
        debian_runner('7.0').converge 'debian::backports'
      end

      it { should add_backports_source 'http://http.debian.net/debian' }
    end

    context 'with specified default mirror' do
      let(:chef_run) do
        debian_runner('7.0') do |node|
          node.set['debian']['mirror'] = 'http://example.com/debian-mirror'
        end.converge 'debian::backports'
      end

      it 'uses it' do
        expect(chef_run).to add_backports_source 'http://example.com/debian-mirror'
      end
    end

    context 'with specified backports mirror' do
      let(:chef_run) do
        debian_runner('7.0') do |node|
          node.set['debian']['backports_mirror'] = 'http://example.com/backports-mirror'
          node.set['debian']['mirror'] = 'http://example.com/default-mirror'
        end.converge 'debian::backports'
      end

      it 'uses it' do
        expect(chef_run).to add_backports_source 'http://example.com/backports-mirror'
      end
    end
  end
end
