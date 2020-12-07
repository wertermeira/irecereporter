# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backoffice::CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:name) { Faker::Name.name }
  let(:attributes) do
    {
      name: name
    }
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
          post :create, params: { category: attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirect to categories' do
        post :create, params: { category: attributes }
        expect(response).to redirect_to(backoffice_categories_path)
      end
    end

    it 'create is fail' do
      attributes[:name] = ''
      post :create, params: { category: attributes }
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: category.slug }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    context 'when accepted' do
      before { put :update, params: { id: category.slug, category: attributes } }

      it 'change name' do
        expect(category.reload.name).to eq(name)
      end

      it 'redirect to categories' do
        expect(response).to redirect_to(backoffice_categories_path)
      end
    end

    it 'update is fail' do
      attributes[:name] = ''
      put :update, params: { id: category.slug, category: attributes }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy is redirect_to' do
      delete :destroy, params: { id: category.slug }
      expect(response).to redirect_to(backoffice_categories_path)
    end

    it 'destroy is deleted' do
      expect do
        delete :destroy, params: { id: category.slug }
      end.to change(Category, :count).by(0)
    end
  end
end
