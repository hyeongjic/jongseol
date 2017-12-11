require 'fcm'
class PushController < ApplicationController
  #acts_as_token_authentication_handler_for User
  #api key = AIzaSyBVcFWK0978HD9vh4WxjmTKrZxcnTQh0W0
  #server key = AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe
  #server key2 = AIzaSyA0yO5SvQAY3XWGZ0ywV3qEvC53yqkEbus
  #project id = jongseol-3e94c
  #server key jin=AAAAbe1dEHY:APA91bE4Kqr7l0BEoRANj9nRLB5_oH8izl5oR_nRZE1tFulE7VjRurtFqaHne7JcvGJI8RzNaTDp0UQpQCloVfN0CJN_HRx_byQRxO1hz9r4JyzrLJseAY_nGyC4ssn1IOqupVX3AfqI



  def push_to_device
    begin
      fcm = FCM.new("AAAAbe1dEHY:APA91bE4Kqr7l0BEoRANj9nRLB5_oH8izl5oR_nRZE1tFulE7VjRurtFqaHne7JcvGJI8RzNaTDp0UQpQCloVfN0CJN_HRx_byQRxO1hz9r4JyzrLJseAY_nGyC4ssn1IOqupVX3AfqI")
      #fcm = FCM.new("AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe")
      registration_ids = "e1tqz0AuzwI:APA91bE1tGnOUQIBZux20BJzbRw4PRX3LHmT14cIDuCGyVKEk2BrZ51HgfTMqrgx38GNsIZB7AIdSkzPsjwOyMqSqcOCt0Z3-qHwH9iQizvC7USqXg43b5M1gTzvP2Bb_ueo4dR8sI2k"
      #registration_ids = User.find_by_rasp_uuid(params:['rasp_uuid']).device_uuid
      options = {
          priority: "high",
          collapse_key: "updated_score",
          notification: {
              title: "침입 탐지",
              body: "침입이 탐지되었습니다.",
              icon: "myicon"}
      }
      response = fcm.send(registration_ids,options)
    rescue => e
      render json: { result: 'fail', message: e.message }, status: e.status
    end
      render json: { result: 'success'}, status: 200
  end

  def push_to_rasp
    a = params['email']
    b = params['id']

    render json: { email: a, id: b}

    # begin
    #   fcm = FCM.new("AAAAbe1dEHY:APA91bE4Kqr7l0BEoRANj9nRLB5_oH8izl5oR_nRZE1tFulE7VjRurtFqaHne7JcvGJI8RzNaTDp0UQpQCloVfN0CJN_HRx_byQRxO1hz9r4JyzrLJseAY_nGyC4ssn1IOqupVX3AfqI")
    #   #fcm = FCM.new("AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe")
    #   registration_ids = "e1tqz0AuzwI:APA91bE1tGnOUQIBZux20BJzbRw4PRX3LHmT14cIDuCGyVKEk2BrZ51HgfTMqrgx38GNsIZB7AIdSkzPsjwOyMqSqcOCt0Z3-qHwH9iQizvC7USqXg43b5M1gTzvP2Bb_ueo4dR8sI2k"
    #   registration_ids = User.find_by_authentication_token(params:['auth_token']).rasp_uuid
    #   if params['flag'] == 1
    #     options = {
    #         priority: "high",
    #         collapse_key: "updated_score",
    #         notification: {
    #             body: "door"
    #         }
    #     }
    #   else params['flag'] == 2
    #     options = {
    #         priority: "high",
    #         collapse_key: "updated_score",
    #         notification: {
    #             body: "camera"
    #         }
    #     }
    #   else params['flag'] == 3
    #     options = {
    #       priority: "high",
    #       collapse_key: "updated_score",
    #       notification: {
    #           body: "camera"
    #       }
    #   }
    #   end
    #   response = fcm.send(registration_ids,options)
    # rescue => e
    #   render json: { result: 'fail', message: e.message }, status: e.status
    # end
    #   render json: { result: 'success'}, status: 200
  end

end


