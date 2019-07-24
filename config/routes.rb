Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: :create do
        collection do
          post :sign_in
        end
      end

      resources :git_hub, only: %i[repositories] do
        collection do
          get :repositories
          get :repository_by_keyword
          get :repository_by_user
        end
      end
    end
  end
end
