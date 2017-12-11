class UsersController < ApplicationController
  acts_as_token_authentication_handler_for User, except: %i[create login]
  # skip_before_action :verify_authenticity_token

  # login
  def login
    email = params['email']
    password = params['password']

    begin
    user = User.all

    render json: { result: user}, status: 200
    end


    # begin
    #   user = User.where(email: email).take
    #
    #   if user.valid_password?(password)
    #     render json: { result: 'Success!', email: user.email, auth_token: user.authentication_token, status: 200}, status: 200
    #   else
    #     render json: { result: 'Wrong password', status: 400}, status: 400
    #   end
    # rescue => e
    #     render json: { result: 'wrong email address', status: 400}, status: 400
    # end
  end

  # sign_up
  def create
    email = params['email']
    encrypted_password = params['encrypted_password']
    encrypted_password_confirm = params['encrypted_password_confirm']
    device_uuid = params['device_uuid']
    rasp_uuid = params['rasp_uuid']

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
        render json: { result: 'fail', message: e.message}, status: 400
    end
  end
end
