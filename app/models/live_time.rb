class LiveTime < ActiveRecord::Base
  belongs_to :live_event
  has_and_belongs_to_many :lives
  has_many :streams

  before_save do
    self.end = self.start + 30*60
  end
end
