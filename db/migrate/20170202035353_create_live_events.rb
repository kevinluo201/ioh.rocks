class CreateLiveEvents < ActiveRecord::Migration
  def change
    create_table :live_events do |t|
      t.date :start_date
      t.date :end_date
      t.date :signup_end
      t.boolean :active

      t.timestamps null: false
    end
  end
end
