Rails.application.routes.draw do
  devise_for :users

  resources :chatrooms do
  	resource :chatroom_user_relationships
  	resources :messages
  end

  resources :direct_messages

  resources :contacts do
  	
  end

  root to: "chatrooms#index"

end
