class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :twitter_screen_name
      t.string :twitter_img_url
      t.string :twitter_id
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
