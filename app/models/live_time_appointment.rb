class LiveTimeAppointment < ActiveRecord::Base
  belongs_to :live
  belongs_to :live_time
end
