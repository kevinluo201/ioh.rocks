class LiveEvent < ActiveRecord::Base
  validates :start_date, :end_date, :signup_end, presence: true

  before_create do
    self.active = false
    true # don't let callbacks return false
  end
  after_save :create_livetimes


  has_many :live_times, dependent: :delete_all

  private

  def create_livetimes
    # create or edit the live event, if there is no according LiveTime, create them
    (self.start_date..self.end_date).each do |d|
      if LiveTime.where("date(start) in (?)", d).empty?
        LiveTime.create_live_times_from_date(d).each do |t|
          self.live_times << t
        end
      end
    end
  end
end
