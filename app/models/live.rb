class Live < ActiveRecord::Base
	belongs_to :live_school
	belongs_to :live_department
	has_and_belongs_to_many :live_times

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :gmail, presence: true, length: { maximum: 255 }, 
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :fb_url, presence: true
	validates :phone, presence: true
	validates :location, presence: true

	before_save do
		self.title = self.name
		self.onair = "yet"
	end
end
