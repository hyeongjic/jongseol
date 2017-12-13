Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  post '/push/device' => 'push#push_to_device'
  post '/push/rasp' => 'push#push_to_rasp'
  post '/regist' => 'push#check_rasp'
  resources :users, only: [] do
    collection do
      post 'login', to: 'users#login'
      post 'sign_up', to: 'users#create'
    end
  end



end
