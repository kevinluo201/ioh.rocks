class CreateLiveDepartments < ActiveRecord::Migration
  def change
    create_table :live_departments do |t|
    	t.string :name
    	t.integer :group
    end
  end
end
