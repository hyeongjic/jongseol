require 'fcm'
class PushController < ApplicationController

  # fcm push
  # 라즈베리파이에서 post 방식으로 요청을 보내면
  # 안드로이드 어플로 push 알람을 보낸다.
  # 라즈베리파이가 a를 보내면 침입탐지 푸쉬를
  # d를 보내면 창문에 있는 거수자의 사진을 받아
  # 아마존의 s3에 보낸뒤 URL을 푸쉬에 담아서 보낸다
  def push_to_device
    begin
      fcm = FCM.new("AAAAtSbtkSc:APA91bHr7lu2SUB9FpxcLHmjd9zlJkWWWDBjs9pnI_6RXGy_nhekKHGKjj0avSQuLr8lUrGG4tCkrLgi9q-n7qma-zRed7WRyUeA74DG6CHCXlSsClJl8jnGjMoJItj5Tht2d-xBmdoe")
      registration_ids = [User.find_by_rasp_uuid(params['did']).device_uuid]
      signal = params['signal']

      if signal == 'a' #a 침입감지
        titles = "detect"
        message = "침입이 탐지되었습니다."
        pic_url = ""
      elsif signal == 'd' #d 얼굴감지
        titles = "face"
        message = "창문에 거수자가 탐지되었습니다."
        a = FileUploader.new
        file = open(params['file'])
        a.store!(file)
        pic_url = "https://s3.ap-northeast-2.amazonaws.com/jongseol-test/uploads/nil_class/"
        pic_url += a.filename
      else
        render json: { result: 'wrong signal'}, status: 400
      end

      options = {
          priority: "high",
          collapse_key: "updated_score",
          notification: {
              title: titles,
              body: message},
          data: {
              pic:  pic_url
          }
      }
      sleep 1
      response = fcm.send(registration_ids, options)

      render json: { result: 'success' }, status: 200
    rescue => e
      render json: { result: 'fail', message: e.message }, status: 400
    end
  end


  # 라즈베리파이가 처음 켜질때 post 방식으로
  # 자신의 일련번호와 등록된 아이피를 보낸다
  # 만약 서버 db에 자신의 일련번호가 없을 시에
  # 서버에 등록을 하고 아이피를 입력한다.
  # 만약 서버에 등록되어있다면 바뀐 아이피만 입력해서 저장한다
  def check_rasp
    begin
      # key value  did/ ip
      did = params['did']
      dip = params['ip']

      rasp = Rasp.find_by_rasp_id(did)
      p rasp
      if rasp.nil?
        rasp = Rasp.new
        rasp.rasp_id = did
        rasp.rasp_ip = dip
      else
        rasp.rasp_ip = dip
      end

      rasp.save

      render json: { result: 'success', rasp_id: rasp.rasp_id,
                     rasp_ip: rasp.rasp_ip }, status: 200
    rescue => e
      render json: { result: 'fail', message: e.message }, status: 400
    end
  end


end


