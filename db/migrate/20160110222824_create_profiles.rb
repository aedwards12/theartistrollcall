class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :artist
      t.string :profile_handle
      t.string :profile_img_url
      t.string :profile_id
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
