CarrierWave.configure do |config|
  #should be configured via figaro or dotenv gem
  config.asset_host = 'http://localhost:3000'
end