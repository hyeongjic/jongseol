require 'fcm'
class PushController < ApplicationController
  #acts_as_token_authentication_handler_for User
  #api key = AIzaSyBVcFWK0978HD9vh4WxjmTKrZxcnTQh0W0
  #server key = AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe
  #server key2 = AIzaSyA0yO5SvQAY3XWGZ0ywV3qEvC53yqkEbus
  #project id = jongseol-3e94c
  #server key jin=AAAAbe1dEHY:APA91bE4Kqr7l0BEoRANj9nRLB5_oH8izl5oR_nRZE1tFulE7VjRurtFqaHne7JcvGJI8RzNaTDp0UQpQCloVfN0CJN_HRx_byQRxO1hz9r4JyzrLJseAY_nGyC4ssn1IOqupVX3AfqI


  #fcm push
  def push_to_device
    #signal = params['signal']

    begin
      #fcm = FCM.new("AAAAbe1dEHY:APA91bE4Kqr7l0BEoRANj9nRLB5_oH8izl5oR_nRZE1tFulE7VjRurtFqaHne7JcvGJI8RzNaTDp0UQpQCloVfN0CJN_HRx_byQRxO1hz9r4JyzrLJseAY_nGyC4ssn1IOqupVX3AfqI")
      fcm = FCM.new("AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe")
      #registration_ids = ["e1tqz0AuzwI:APA91bE1tGnOUQIBZux20BJzbRw4PRX3LHmT14cIDuCGyVKEk2BrZ51HgfTMqrgx38GNsIZB7AIdSkzPsjwOyMqSqcOCt0Z3-qHwH9iQizvC7USqXg43b5M1gTzvP2Bb_ueo4dR8sI2k"]
      #registration_ids = ["cGy4rVKmBEY:APA91bHJDsVQryGYFILnMjRftgxxmUel1yfchwbj1ABQDFICyGPYt2TOny_UFj0BOLmMHL3p43EQtDOK_1GwShfdkJ837u10sZQq2os8LvUXTIhmVic4oOkHAXokeVrt_eCWovvau9"]
      registration_ids = User.find_by_rasp_uuid(params['did']).device_uuid

      signal = 'a'#params['signal']

      if signal == 'a' #a 침입감지
        options = {
            priority: "high",
            collapse_key: "updated_score",
            notification: {
                title: "침입 탐지",
                body: "침입이 탐지되었습니다.",
                icon: "myicon"}
        }
      elsif signal == 'd' #d 얼굴감지
        options = {
            priority: "high",
            collapse_key: "updated_score",
            notification: {
                title: "거수자 탐지",
                body: "창문에 거수자가 탐지되었습니다.",
                icon: "myicon"}
        }
      else
        render json: { result: 'wrong signal'}, status: 400
      end
      response = fcm.send(registration_ids, options)

      render json: { result: 'success' }, status: 200
    rescue => e
      render json: { result: 'fail', message: e.message }, status: e.status
    end
  end

  #test
  def push_to_rasp
    begin
      a = FileUploader.new
      file = open(params['file'])
      a.store!(file)
      b = params['signal']
      render json: { result: 'success', signal: b}, status: 200
    rescue => e
      render json: { result: 'fail', message: e.message }, status: 400
    end
  end

  def check_rasp
    begin
      # key value  did/ ip
      did = params['did']
      dip = params['ip']

      rasp = Rasp.find_by_rasp_id(did)

      if rasp.nil?
        rasp.rasp_id = did
        rasp.rasp_id = dip
      else
        rasp.rasp_ip = dip
      end

      rasp.save

      render json: { result: 'success', rasp_id: did, rasp_ip: dip }, status: 200
    rescue => e
      render json: { result: 'fail', message: e.message }, status: 400
    end
  end


end


