Rails.application.routes.draw do
  devise_for :users

  post '/push/device' => 'push#push_to_device' #push메세지
  post '/regist' => 'push#check_rasp' #라즈베리파이 등록

  resources :users, only: [] do
    collection do
      post 'login', to: 'users#login' #로그인
      post 'sign_up', to: 'users#create' #회원가입
    end
  end

end
