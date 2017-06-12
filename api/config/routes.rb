Rails.application.routes.draw do
  namespace :api do
    resources :artists, only: :index

    resources :artworks do
      member do
        post :publish
        post :unpublish
      end
    end
  end
end
