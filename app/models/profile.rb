class Profile < ActiveRecord::Base
	belongs_to :user, foreign_key: "user_id", class_name: 'User'

	validates :name, presence: true
	has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
    geocoded_by :full_street_address   # can also be an IP address


   def full_street_address
     [add1, add2, city, state, post_code].compact.join(', ')
   end
    after_validation :geocode          # auto-fetch coordinates

  	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  	validates_attachment_size :photo, less_than: 5.megabytes
end
