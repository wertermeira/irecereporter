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
end
