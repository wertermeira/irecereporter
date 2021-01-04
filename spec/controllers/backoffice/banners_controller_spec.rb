# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backoffice::BannersController, type: :controller do
  let(:admin) { create(:admin) }
  let(:banner) { create(:banner) }
  let(:name) { Faker::Name.name }
  let(:attributes) do
    {
      name: name,
      email: Faker::Internet.email,
      date_start: Time.current.to_date,
      date_end: (Time.current + 2.days).to_date,
      banner: Rack::Test::UploadedFile.new(File.new("#{Rails.root}/spec/support/fixtures/image.jpg")),
      active: true,
      kind: Banner::KINDS.keys.sample.to_s
    }
  end

  before do
    session[:user_id] = admin.id
  end

  describe '#index' do
    context 'when is success' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    context 'when created' do
      it 'created' do
        expect  do
          post :create, params: { banner: attributes }
        end.to change(Banner, :count).by(1)
      end

      it 'redirect to banners' do
        post :create, params: { banner: attributes }
        expect(response).to redirect_to(backoffice_banners_path)
      end
    end

    it 'create is fail' do
      attributes[:name] = ''
      post :create, params: { banner: attributes }
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: banner.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    context 'when accepted' do
      before { put :update, params: { id: banner.id, banner: attributes } }

      it 'change name' do
        expect(banner.reload.name).to eq(name)
      end

      it 'redirect to banners' do
        expect(response).to redirect_to(backoffice_banners_path)
      end
    end

    it 'update is fail' do
      attributes[:name] = ''
      put :update, params: { id: banner.id, banner: attributes }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy is redirect_to' do
      delete :destroy, params: { id: banner.id }
      expect(response).to redirect_to(backoffice_banners_path)
    end

    it 'destroy is deleted' do
      expect do
        delete :destroy, params: { id: banner.id }
      end.to change(Banner, :count).by(0)
    end
  end
end
