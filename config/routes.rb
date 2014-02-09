AmChat::Application.routes.draw do
  
  # Render views
  get 'chat/' => 'chat#index'
  root to: 'user#index'
  
  # message history partial
  get 'chat/load_messages'
  post 'chat/new_message'
  
  # Clear messages
  post 'chat/clear_messages'
  
  # send message action
  post 'chat/send_message'
  
  # Pass id to user controller
  get 'user/login/:id' => 'user#login'
  
end
