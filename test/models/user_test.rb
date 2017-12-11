require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '정상적으로 값이 들어가는 경' do
    user = User.new
    user.email = 'test@tset.net'
    user.device_uuid = 'asdfasdf'

    user.password = 'asdfasdf'
    assert user.valid?
  end

  test '패스워드가 없는 경우 오류' do
    user = User.new
    user.email = 'test@tset.net'
    user.device_uuid = 'asdfasdf'

    assert user.invalid?
  end
end
