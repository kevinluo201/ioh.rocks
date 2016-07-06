class LiveTime < ActiveRecord::Base
	has_and_belongs_to_many :lives

	before_save do
		self.end = self.start + 30*60
	end
end
