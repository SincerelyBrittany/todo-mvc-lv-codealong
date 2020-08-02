Rails.application.config.middleware.use OmniAuth::Builder do
    #client key - indentifies the github application
    #client secret - prevents other developers - password for my github application
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
   