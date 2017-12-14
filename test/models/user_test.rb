require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '정상적으로 값이 들어가는 경우' do
    user = User.new
    user.email = 'name@email.com'
    user.device_uuid = 'token'
    user.rasp_uuid = 'rasp'
    user.password = 'password'
    assert user.valid?
  end

  test '패스워드가 없는 경우 오류' do
    user = User.new
    user.email = 'name@email.com'
    user.device_uuid = 'token'
    user.rasp_uuid = 'rasp'
    assert user.invalid?
  end
  test '패스워드가 6글자 미안인 경우' do
    user = User.new
    user.email = 'name@email.com'
    user.device_uuid = 'token'
    user.rasp_uuid = 'rasp'
    user.password = 'pass'
    assert user.invalid?
  end


  test '같은  email이 있는 경우' do
    user = User.new
    user.email = 'name@email.com'
    user.device_uuid = 'token'
    user.rasp_uuid = 'rasp'
    user.password = 'password'

    user2 = User.new
    user2.email = 'name@email.com'
    user2.device_uuid = 'token'
    user2.rasp_uuid = 'rasp'
    user2.password = 'password'
    assert user.invalid?
  end



end
