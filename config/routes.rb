Rails.application.routes.draw do
  
  root "top#index"
  
  get "about" => "top#about", as: "about"
  
  resources :members do
    get "search", on: :collection
  end 
  
  resource :session, only: [:create, :destroy]
  
end
