OmniAuth.config.full_host = ENV["APPLICATION_HOST"] if ENV["APPLICATION_HOST"]

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
  provider :twitter, Rails.application.secrets.twitter_consumer_key, Rails.application.secrets.twitter_consumer_secret
end
