# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backoffice::AdminsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:name) { Faker::Name.name }
  let(:attributes) do
    {
      name: name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      active: true,
      profile: %w[admin editor visitor].sample
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
          post :create, params: { admin: attributes }
        end.to change(Admin, :count).by(1)
      end

      it 'redirect to admins' do
        post :create, params: { admin: attributes }
        expect(response).to redirect_to(backoffice_admins_path)
      end
    end

    it 'create is fail' do
      attributes[:name] = ''
      post :create, params: { admin: attributes }
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: admin.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    context 'when accepted' do
      before { put :update, params: { id: admin.id, admin: attributes } }

      it 'change name' do
        expect(admin.reload.name).to eq(name)
      end

      it 'redirect to admins' do
        expect(response).to redirect_to(backoffice_admins_path)
      end
    end

    it 'update is fail' do
      attributes[:name] = ''
      put :update, params: { id: admin.id, admin: attributes }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy is redirect_to' do
      delete :destroy, params: { id: admin.id }
      expect(response).to redirect_to(backoffice_admins_path)
    end

    it 'destroy is deleted' do
      expect do
        delete :destroy, params: { id: admin.id }
      end.to change(Admin, :count).by(0)
    end
  end
end
