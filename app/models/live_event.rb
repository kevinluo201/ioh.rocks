class LiveEvent < ActiveRecord::Base
  validates :start_date, :end_date, :signup_end, presence: true

  before_create do
    active = false
    true # don't let callbacks return false
  end
  after_save :create_livetimes

  has_many :live_times, dependent: :delete_all

  def self.active_event
    includes(live_times: [:lives]).where(active: true).first
  end

  # classify the LiveTime by time then sort by date
  # this is for presenting in table's row
  def live_times_for_agenda
    LiveTime::Times.map do |t|
      times = live_times.select { |lt| lt.start.strftime('%-H:%M') == t }
      times.sort! { |a, b| a.start <=> b.start }
    end
  end

  private

  def create_livetimes
    # create or edit the live event, if there is no according LiveTime, create them
    (start_date..end_date).each do |d|
      if LiveTime.where("date(start) in (?)", d).empty?
        LiveTime.create_live_times_from_date(d).each do |t|
          live_times << t
        end
      end
    end
  end
end
