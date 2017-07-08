Rails.application.routes.draw do
  devise_for :users

  resources :chatrooms do
  	resource :chatroom_user_relationships
  	resources :messages
  end

  resources :direct_messages

  resources :contacts do
  	collection do
  		get :search_friends
  	end
  	member do
  		post :request_friendship
  		post :defriend_request
  		post :accept_friendship
  	end
  end

  root to: "chatrooms#index"

end
