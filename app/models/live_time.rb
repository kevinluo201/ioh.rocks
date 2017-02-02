class LiveTime < ActiveRecord::Base
  Times = %w(6:00 6:30 7:00 7:30 8:00 12:00 12:30 13:00 13:30 14:00)
  belongs_to :live_event
  has_many :streams
  has_many :live_time_appointments
  has_many :lives, through: :live_time_appointments

  before_save do
    self.end = self.start + 30*60
  end

  def self.create_live_times_from_date(date)
    date = date.strftime('%m/%d/%Y')

    times = []
    Times.each do |t|
      # prevent strptime create Time from +0000
      time = LiveTime.create(start: DateTime.strptime("#{date} #{t} +0800", "%m/%d/%Y %H:%M %Z"))
      times << time
    end

    times
  end
end
