class CreateProfilesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t| 
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :email
      t.integer :user_id
    end
  end
end