class Live < ActiveRecord::Base
	belongs_to :live_school
	belongs_to :live_department
	has_many :live_time_appointments, dependent: :destroy
	has_many :live_times, through: :live_time_appointments
	has_and_belongs_to_many :live_events

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :gmail, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	validates :name, presence: true
	validates :phone, :school, :department, presence: true

	before_save do
		self.title = self.name
		self.time_count = self.live_times.count
	end

	def self.active_lives
		LiveEvent.active_event.live_times.inject([]) { |ary, t| ary << t.lives }.
							flatten.uniq.sort { |a, b| a.name <=> b.name }
	end
end
