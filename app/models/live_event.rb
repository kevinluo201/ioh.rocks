class LiveEvent < ActiveRecord::Base
  validates :start_date, :end_date, :signup_end, presence: true
  validate :end_date_cannot_smaller_than_start_neither_does_signup_date

  def end_date_cannot_smaller_than_start_neither_does_signup_date
    if end_date < start_date
      errors.add(:end_date, 'end date cannot smaller than start date, please check')
    end

    if signup_end > start_date
      errors.add(:signup_end, 'signup_end cannot greater than start date, please check')
    end
  end

  before_create do
    active = false
    create_livetimes
  end

  has_many :live_times, dependent: :delete_all

  # find the only one active_event and eager load other information
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

  def period
    start_date..end_date
  end

  def length
    period.count
  end

  private

  def create_livetimes
    # create or edit the live event, if there is no according LiveTime, create them
    (start_date..end_date).each do |d|
      LiveTime.create_live_times_from_date(d).each do |t|
        live_times << t
      end
    end
  end
end
