Rails.application.routes.draw do
  namespace :api do
    resources :artists
    resources :artworks do
      member do
        post :publish
        post :unpublish
      end
    end
    resources :images
  end
end
