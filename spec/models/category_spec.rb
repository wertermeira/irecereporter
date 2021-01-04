require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name slug].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when associatios' do
    it { is_expected.to have_many(:post_categories).dependent(:destroy) }
    it { is_expected.to have_many(:posts).through(:post_categories) }
  end

  context 'when validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(150) }
  end
end
