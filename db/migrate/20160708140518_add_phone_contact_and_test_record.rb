class AddPhoneContactAndTestRecord < ActiveRecord::Migration
  def change
  	add_column :lives, :phone_contact, :boolean
  	add_column :lives, :test_record, :string
  end
end
