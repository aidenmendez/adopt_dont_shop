Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"


  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show", as: "pets_show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"

  get "/applications/new", to: "applications#new", as: "applications_new"
  get "/applications/:id", to: "applications#show", as: "applications_show"
  post "/applications", to: "applications#create", as: "applications_create"
  patch "/applications/:id", to: "applications#update", as: "applications_update"

  post "/pet_applications", to: "pet_applications#create", as: "pet_applications_create"
  patch "/pet_applications", to: "pet_applications#update", as: "pet_applications_update"
  
  scope :admin, as: "admin" do
    resources :applications, controller: "admin_applications", only: [:show]
  end
end
