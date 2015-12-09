Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret,
  {
  	:image_size => 'bigger',
  	:secure_image_url => true
  }
  provider :facebook, Rails.application.secrets.facebook_api_key, Rails.application.secrets.facebook_api_secret, :image_size => 'square', :secure_image_url => true
end