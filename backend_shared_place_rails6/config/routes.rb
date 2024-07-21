Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #user routes
  get 'api/users', to:'users#get_users'
  post 'api/users/signup', to:'users#signup'
  post 'api/users/login', to:'users#login'
  

  #places routes
  get 'api/places/user/:uid', to:'places#getPlacesByUserId'
  post 'api/places', to:'places#createPlace'
  get 'api/places/:pid', to:'places#getPlaceByPlaceId'
  patch 'api/places/:pid', to:'places#updateByPlaceId'
  delete 'api/places/:pid', to:'places#deleteByPlaceId'

end
