require 'sidekiq/web'

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: %i[new create destroy]
  namespace :services do
    resources :weather, only: :index
  end
  namespace :backoffice do
    resources :admins
    resources :pages, except: :show 
    resources :categories, except: :show
    resources :posts do
      get ':id/gallery', to: 'posts#gallery', on: :collection, as: :gallery
    end
    resources :galleries, only: %i[show create destroy]
    resources :banners do
      get 'render_html/:id', on: :collection, to: 'banners#banner_render'
    end
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USERNAME', 'admin'))) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD', '123456')))
  end if Rails.env.production?
  mount Sidekiq::Web => 'sidekiq'
  root to: 'frontend/home#index'
  get '/noticias', to: 'frontend/posts#index', as: :posts
  get '/:slug', to: 'frontend/posts#show', as: :post
end
