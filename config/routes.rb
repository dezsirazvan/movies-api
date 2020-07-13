Rails.application.routes.draw do
  use_doorkeeper

  use_doorkeeper scope: 'api/v1' do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        post :login , on: :collection
      end
    end
  end
end
