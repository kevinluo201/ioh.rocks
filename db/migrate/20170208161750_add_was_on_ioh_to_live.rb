class AddWasOnIohToLive < ActiveRecord::Migration
  def change
    add_column :lives, :was_on_ioh, :boolean
  end
end
