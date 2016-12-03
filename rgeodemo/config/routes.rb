Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"
  
  namespace :admin do
    resources :life_types
    resources :plant_classes
    resources :plant_habitats
    resources :plant_kingdoms
    resources :plant_orders
    resources :plant_phylums
    resources :used_parts
    resources :medicinal_plants
    resources :import do
      collection do
        post :import_medicinal_plant
        post :import_location
        post :import_medicinal_plants_locations
      end
    end

    resources :location_import do
    end
  end

  resources :medicinal_plants do
  end
  resources :user_medicinal_plants do
    collection do
      get :detail
      get :statitic
    end
  end
  resources :export do
    collection do
      get :export_statitic_medicinal_plant
    end
  end
end
