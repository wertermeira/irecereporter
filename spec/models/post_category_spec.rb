require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[post_id category_id].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:category) }
  end
end
