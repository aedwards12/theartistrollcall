class Addinstragamtoartists < ActiveRecord::Migration
  def change
    add_column :artists, :instagram_user_name, :string
    add_column :artists, :instagram_img_url, :string
    add_column :artists, :instagram_id, :string
    add_column :artists, :instagram_full_name, :string
  end
end
