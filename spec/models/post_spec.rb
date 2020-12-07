require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name slug subname headline body summary active feature_post].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when association' do
    it { is_expected.to belong_to(:page).optional }
    it { is_expected.to have_many(:post_categories).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:post_categories) }
  end

  context 'when validation fields' do
    %i[name body].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_length_of(:name).is_at_most(140) }
    it { is_expected.to validate_length_of(:subname).is_at_most(140) }
    it { is_expected.to validate_length_of(:headline).is_at_most(100) }
    it { is_expected.to validate_length_of(:summary).is_at_most(250) }
  end

  context 'when validation images' do
    let(:type_allow) { %w[image/png image/gif image/jpg image/jpeg] }

    %i[image cover].each do |field|
      it { is_expected.to validate_size_of(field).less_than(4.megabytes) }
      it { is_expected.to validate_size_of(field) }
      it { is_expected.to validate_content_type_of(field).allowing(type_allow) }
      it { is_expected.not_to validate_content_type_of(field).allowing(%w[image/tif doc/pdf]) }
    end
  end
end
