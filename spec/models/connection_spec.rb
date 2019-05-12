# frozen_string_literal: true

require 'spec_helper'

describe Connection do
  describe '::active' do
    subject { described_class.active }

    let(:user) { create(:user) }
    let(:server) { create(:server) }
    let(:second_user) { create(:user) }

    context 'one last connect exists' do
      before do
        2.times do
          create(:connect, user: user)
          create(:disconnect, user: user)
        end
        create(:connect, user: user)
      end

      it 'returns only active connections' do
        expect(subject.count).to eq 1
      end
    end

    context 'one connect and another disconnect exist' do
      before do
        create(:connect, user: user)
        create(:disconnect, user: second_user)
      end

      it 'returns only active connections' do
        expect(subject.count).to eq 1
      end
    end

    context 'two connects exist' do
      before do
        create(:connect, user: user, server: server)
        create(:disconnect, user: second_user, server: server)
        create(:connect, server: server)
      end

      it 'returns only active connections' do
        expect(subject.count).to eq 2
      end
    end

    context 'no connects exist' do
      it 'returns only active connections' do
        expect(subject.count).to eq 0
      end
    end
  end
end

# == Schema Information
#
# Table name: connections
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  server_id   :integer
#  traffic_in  :float
#  traffic_out :float
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
