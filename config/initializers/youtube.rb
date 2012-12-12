module YoutubeConfig
  CONFIG = YAML.load_file(Rails.root.join("config/youtube.yml"))[Rails.env]
  DEV_KEY = CONFIG['dev_key']
  CLIENT_ID = CONFIG['client_id']
  CLIENT_SECRET = CONFIG['client_secret']
  USERNAME = CONFIG['username']
  PASSWORD = CONFIG['password']
end
