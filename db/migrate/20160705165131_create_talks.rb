class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
    	t.integer :ioh_id
    	t.string :title
    	t.string :post_name
    end
  end
end
