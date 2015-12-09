class Card < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	after_create :remake_slug
	
	def slug_candidates
    [
      :name,
      [:name, :id],
    ]
  end

  def remake_slug
    self.update_attribute(:slug, nil)
    self.save!
  end

  #You don't necessarily need this bit, but I have it in there anyways
  def should_generate_new_friendly_id?
    new_record? || self.slug.nil?
  end

	has_many :tweets
	belongs_to :user
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, :s3_protocol => :https
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
