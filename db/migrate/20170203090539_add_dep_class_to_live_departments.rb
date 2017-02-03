class AddDepClassToLiveDepartments < ActiveRecord::Migration
  def change
    add_column :live_departments, :dep_class, :integer
  end
end
