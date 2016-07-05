class AddRelationToTalk < ActiveRecord::Migration
  def change
  	add_reference :talks, :live_school, index: true, foreign_key: true
  	add_reference :talks, :live_department, index: true, foreign_key: true
  end
end
