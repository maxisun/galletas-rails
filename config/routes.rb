Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "api/v1/products#index", defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :products, defaults: { format: :json }
      resources :users, only: :create do
        collection do
          post 'login'
        end
      end
    end
  end

end
