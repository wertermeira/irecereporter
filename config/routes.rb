Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :backoffice do
    resources :pages, except: :show 
    resources :categories, except: :show 
  end
end
