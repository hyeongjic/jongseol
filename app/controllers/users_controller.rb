class UsersController < ApplicationController
  acts_as_token_authentication_handler_for User, except: %i[create login]

  # login
  # 등록된 유저인지 아닌지 확인하는 코드
  # device 젬을 이용해서 만들었다.
  def login
    email = params['email']
    password = params['password']

    begin
      user = User.where(email: email).take

      if user.valid_password?(password)
        rasp = Rasp.find_by_rasp_id(user.rasp_uuid)
        render json: { result: 'Success!', email: user.email,
                       auth_token: user.authentication_token,
                       status: 200}, status: 200
      else
        render json: { result: 'Wrong password', status: 400 }, status: 400
      end
    rescue => e
        render json: { result: 'wrong email address', status: 400 }, status: 400
    end
  end

  # sign_up
  # 회원가입을 하는 코드
  # 안드로이드로부터 이메일, 비밀번호, 비밀번호확인,
  # 라즈베리파이 일련번호를 입력받아 db에 저장한다.
  # 추가로 push메세지를 받기 위해 고유의 토큰값을
  # 서버로 보내 같이 db에 저장한다
  def create
    email = params['email']
    encrypted_password = params['encrypted_password']
    encrypted_password_confirm = params['encrypted_password_confirm']
    device_uuid = params['device_uuid']
    rasp_uuid = params['rasp_uuid']

    if Rasp.find_by_rasp_id(rasp_uuid).nil?
      render json: { result: 'fail', message: '등록된 라즈베리파이 아이디가 없습니다.'}, status: 400
    else
      new_user = User.new
      new_user.email = email
      new_user.password = encrypted_password
      new_user.password_confirmation = encrypted_password_confirm
      new_user.device_uuid = device_uuid
      new_user.rasp_uuid = rasp_uuid
      begin
        User.transaction do
          new_user.save!
          render json: { result: 'Success'}, status: 200
        end
      rescue => e
        render json: { result: 'fail', message: '회원가입에 실패 했습니다.'}, status: 400
      end
    end
  end
end
