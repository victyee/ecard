class Tweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :card

	validates :user_id, :body, presence: true
	
	before_create :post_to_twitter

	acts_as_votable
	
	def post_to_twitter
		# user.twitter.update(body)
	end
end
