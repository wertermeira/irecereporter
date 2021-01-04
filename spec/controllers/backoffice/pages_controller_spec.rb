# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backoffice::PagesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:page) { create(:page) }
  let(:name) { Faker::Name.name }
  let(:attributes) do
    {
      name: name
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
          post :create, params: { page: attributes }
        end.to change(Page, :count).by(1)
      end

      it 'redirect to pages' do
        post :create, params: { page: attributes }
        expect(response).to redirect_to(backoffice_pages_path)
      end
    end

    it 'create is fail' do
      attributes[:name] = ''
      post :create, params: { page: attributes }
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: page.slug }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    context 'when accepted' do
      before { put :update, params: { id: page.slug, page: attributes } }

      it 'change name' do
        expect(page.reload.name).to eq(name)
      end

      it 'redirect to pages' do
        expect(response).to redirect_to(backoffice_pages_path)
      end
    end

    it 'update is fail' do
      attributes[:name] = ''
      put :update, params: { id: page.slug, page: attributes }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy is redirect_to' do
      delete :destroy, params: { id: page.slug }
      expect(response).to redirect_to(backoffice_pages_path)
    end

    it 'destroy is deleted' do
      expect do
        delete :destroy, params: { id: page.slug }
      end.to change(Page, :count).by(0)
    end
  end
end
