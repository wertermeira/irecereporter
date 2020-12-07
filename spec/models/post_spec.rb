require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name slug subname headline body summary active feature].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when validation' do
    %i[name body].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_length_of(:name).is_at_most(140) }
    it { is_expected.to validate_length_of(:subname).is_at_most(140) }
    it { is_expected.to validate_length_of(:headline).is_at_most(100) }
    it { is_expected.to validate_length_of(:summary).is_at_most(250) }
  end
end
