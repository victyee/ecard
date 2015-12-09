class User < ActiveRecord::Base
	has_many :tweets
	has_many :cards
	# belongs_to :card
	devise :database_authenticatable, :omniauthable
	acts_as_voter

	def self.find_or_create_from_auth_hash(auth_hash)
		user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
		user.update(
			name: auth_hash.info.name,
			profile_image: auth_hash.info.image,
			token: auth_hash.credentials.token,
			secret: auth_hash.credentials.secret,
			nickname: auth_hash.info.nickname
			)
		if user.provider == 'twitter'
			user.update(
				url: auth_hash.info.urls.Twitter
			)
		elsif user.provider == 'facebook'
			user.update(
				url: auth_hash.extra.raw_info.id
			)
		end
		user
	end

	def twitter
		@client ||= Twitter::REST::Client.new do |config|
		  config.consumer_key        = Rails.application.secrets.twitter_api_key
		  config.consumer_secret     = Rails.application.secrets.twitter_api_secret
		  config.access_token        = token
		  config.access_token_secret = secret
		end
	end
end
