shared_examples 'loads created by last days' do |model_name|
  let!(:record1) { create(model_name) }
  let!(:record2) { create(model_name) }
  let!(:record3) { create(model_name, created_at: 12.days.ago) }

  describe 'loads all records created in selected range' do
    subject { model_name.to_s.classify.constantize.in_days(days_number) }

    context 'range is one week' do
      let(:days_number) { 7 }

      it 'returns first record' do
        expect(subject).to include record1
      end

      it 'returns second record' do
        expect(subject).to include record2
      end

      it 'contains two records' do
        expect(subject.size).to eq 2
      end
    end

    context 'range is 20 days' do
      let(:days_number) { 20 }

      it 'returns first record' do
        expect(subject).to include record1
      end

      it 'returns second record' do
        expect(subject).to include record2
      end

      it 'returns third record' do
        expect(subject).to include record3
      end

      it 'contains three records' do
        expect(subject.size).to eq 3
      end
    end
  end
end
