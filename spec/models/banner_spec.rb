require 'rails_helper'

RSpec.describe Banner, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name active date_start date_end kind].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when validation' do
    %i[name date_start date_end kind].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_length_of(:name).is_at_most(200) }
  end

  context 'when validation images' do
    let(:type_allow) { %w[image/png image/gif image/jpg image/jpeg] }

    it { is_expected.to validate_attached_of(:banner) }
    it { is_expected.to validate_size_of(:banner).less_than(4.megabytes) }
    it { is_expected.to validate_size_of(:banner) }
    it { is_expected.to validate_content_type_of(:banner).allowing(type_allow) }
    it { is_expected.not_to validate_content_type_of(:banner).allowing(%w[image/tif doc/pdf]) }
  end
end
