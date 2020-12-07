require 'rails_helper'

RSpec.describe Backoffice::PostsController, type: :controller do
  let(:category_count) { rand(2..10) }
  let(:categories) { create_list(:category, category_count) }
  let(:attributes) do
    {
      name: Faker::Lorem.sentence(word_count: 3),
      subname: Faker::Lorem.sentence(word_count: 3),
      headline: Faker::Lorem.sentence(word_count: 1),
      body: Faker::Lorem.sentence(word_count: 10),
      summary: Faker::Lorem.sentence(word_count: 5),
      active: %w[true false].sample,
      feature_post: %w[true false].sample,
      category_ids: categories.pluck(:id)
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

  describe '#show' do
    it 'returns http success' do
      get :show, params: { id: post.slug }
      expect(response).to have_http_status(:success)
    end

    it 'returns http nof found' do
      get :show, params: { id: 'notfoundid' }
      expect(response).to have_http_status(:not_found)
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
          post :create, params: { post: attributes }
        end.to change(Post, :count).by(1)
      end

      it 'created with categories' do
        post :create, params: { post: attributes }
        expect(Post.last.categories.count).to eq(category_count)
      end

      it 'redirect to posts' do
        post :create, params: { post: attributes }
        expect(response).to redirect_to(backoffice_posts_path)
      end
    end

    it 'create is fail' do
      attributes[:name] = ''
      post :create, params: { post: attributes }
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'returns http success' do
      get :edit, params: { id: post.slug }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    context 'when accepted' do
      before { put :update, params: { id: post.slug, post: attributes } }

      it 'change name' do
        expect(post.reload.name).to eq(name)
      end

      it 'redirect to posts' do
        expect(response).to redirect_to(backoffice_posts_path)
      end
    end

    it 'update is fail' do
      attributes[:name] = ''
      put :update, params: { id: post.slug, post: attributes }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy is redirect_to' do
      delete :destroy, params: { id: post.slug }
      expect(response).to redirect_to(backoffice_posts_path)
    end

    it 'destroy is deleted' do
      expect do
        delete :destroy, params: { id: post.slug }
      end.to change(Post, :count).by(0)
    end
  end
end
