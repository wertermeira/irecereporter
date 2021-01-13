Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: %i[new create destroy]
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

  root to: 'frontend/home#index'
  get '/noticias', to: 'frontend/posts#index', as: :posts
  get '/:slug', to: 'frontend/posts#show', as: :post
end
