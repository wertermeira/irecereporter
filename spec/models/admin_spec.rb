require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name email profile password_digest token active].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when validation' do
    %i[name email profile].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it { is_expected.to allow_value('owner@site.com').for(:email) }
    it { is_expected.not_to allow_value('owner@site').for(:email) }

    %i[name email password password_confirmation profile].each do |field|
      it { is_expected.to validate_presence_of(field).on(:create) }
    end

    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end
end
