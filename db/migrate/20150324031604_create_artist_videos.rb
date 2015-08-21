class CreateArtistVideos < ActiveRecord::Migration
  def change
    create_table :artist_videos do |t|
      t.belongs_to :artist
      t.belongs_to :video
      t.string :artist_role

      t.timestamps null: false
    end
  end
end
