Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    # provider :github,'846f4dbdecbd76a3a709Y','0e543ca8edf6766c9ae49a7eff309b4926f40314'
  end
   