Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :mobile do
      resources :sessions do
        patch 'checkin', on: :collection
      end
    end
  end
end
