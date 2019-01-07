# frozen_string_literal: true

shared_examples 'total statistics result' do |amount|
  it 'is a hash' do
    expect(subject.class).to eq Hash
  end

  it 'not empty' do
    expect(subject.size).not_to eq 0
  end

  describe 'total amount' do
    it 'is not zero' do
      expect(subject[:total]).to eq amount
    end
  end
end

shared_examples 'total statistics discrete result' do |class_name|
  describe 'discrete values' do
    it 'is an array' do
      expect(subject[:discrete].class).to eq Array
    end

    it 'size equals discrete days number plus today' do
      expect(subject[:discrete].size).to eq (class_name::DESCRETE_DAYS_NUMBER + 1)
    end
  end
end
