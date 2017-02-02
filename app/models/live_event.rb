class LiveEvent < ActiveRecord::Base
  validates :start_date, :end_date, :signup_end, presence: true

  before_create do
    self.active = false
    create_livetimes
  end

  has_many :live_times, dependent: :destroy

  private

  def create_livetimes
    (self.start_date..self.end_date).each do |d|
      d = d.strftime('%m/%d/%Y')
      times = LiveTime.create([
      {start: DateTime.strptime("#{d} 6:00", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 6:30", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 7:00", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 7:30", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 8:00", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 12:00", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 12:30", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 13:00", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 13:30", "%m/%d/%Y %H:%M")},
      {start: DateTime.strptime("#{d} 14:00", "%m/%d/%Y %H:%M")}])

      times.each { |t| self.live_times << t }
    end
  end
end
