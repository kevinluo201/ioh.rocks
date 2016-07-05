class CreateLiveSchools < ActiveRecord::Migration
  def change
    create_table :live_schools do |t|
    	t.string :name
    end
  end
end
