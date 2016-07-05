class LiveSchool < ActiveRecord::Base
	has_many :live
	has_many :talk
end
