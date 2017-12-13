CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      'AKIAJWLKWOJ6MG76UTBQ',
      aws_secret_access_key:  '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',
      region:                 'ap-northeast-2',
      endpoint:               'https://s3.ap-northeast-2.amazonaws.com'
  }
  # config.fog_directory = 'elasticbeanstalk-ap-northeast-2-750921712434'
  config.fog_directory = 'jongseol-test'
  config.fog_public = 'true'
  config.cache_storage = :fog
  config.fog_attributes = {}
end