class CreateIohUrls < ActiveRecord::Migration
  def change
    create_table :ioh_urls do |t|
      t.string :name
      t.string :school
      t.string :ioh_url

      t.timestamps null: false
    end
  end
end
