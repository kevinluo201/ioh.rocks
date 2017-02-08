class LiveTime < ActiveRecord::Base
  Times = %w(19:00 19:30 20:00 20:30 21:00 21:30 22:00)
  belongs_to :live_event
  has_many :live_time_appointments, dependent: :destroy
  has_many :lives, through: :live_time_appointments, source: :live

  before_save do
    self.end = self.start + 30*60
  end

  def self.create_live_times_from_date(date)
    date = date.strftime('%m/%d/%Y')

    Times.map do |t|
      # prevent strptime create Time from +0000
      LiveTime.create(start: DateTime.strptime("#{date} #{t} +0800", "%m/%d/%Y %H:%M %Z"))
    end

  end
end
