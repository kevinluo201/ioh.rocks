class CreateLivesLiveEvents < ActiveRecord::Migration
  def change
    create_table :lives_live_events do |t|
      t.belongs_to :live, index: true
      t.belongs_to :live_event, index: true
    end
  end
end
