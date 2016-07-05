class AddFeedback < ActiveRecord::Migration
  def change
  	add_column :lives, :feedback, :text, :limit => 4294967295
  end
end
