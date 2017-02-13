class CreateLivesLiveEvents < ActiveRecord::Migration
  def change
    create_table :live_events_lives do |t|
      t.belongs_to :live, index: true
      t.belongs_to :live_event, index: true
    end
  end
end
