class AddTimesCount < ActiveRecord::Migration
  def change
  	add_column :lives, :time_count, :integer
  end
end
