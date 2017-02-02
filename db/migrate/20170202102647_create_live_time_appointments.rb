class CreateLiveTimeAppointments < ActiveRecord::Migration
  def change
    create_table :live_time_appointments do |t|
      t.belongs_to :live, index: true
      t.belongs_to :live_time, index: true
      t.boolean :final_decision
      t.timestamps
    end
  end
end
