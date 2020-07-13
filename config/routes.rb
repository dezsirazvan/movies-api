Rails.application.routes.draw do
  use_doorkeeper

  use_doorkeeper scope: 'api/v1' do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        post :login , on: :collection
        get  :movies_and_seasons, on: :collection
        get  :library, on: :collection
        post :purchase, on: :collection
      end

      resources :movies, only: [:index]

      resources :seasons, only: [:index]
    end
  end
end
