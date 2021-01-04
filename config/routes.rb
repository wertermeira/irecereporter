Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: %i[new create destroy]
  namespace :backoffice do
    resources :admins
    resources :pages, except: :show 
    resources :categories, except: :show
    resources :posts
    resources :banners do
      get 'render_html/:id', on: :collection, to: 'banners#banner_render'
    end
  end
end
