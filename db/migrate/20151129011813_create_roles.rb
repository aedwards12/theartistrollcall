class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :video
      t.string :label, null: :false

      t.timestamps null: false
    end

    add_column :artist_videos, :role_id, :integer, references: :roles
  end

end
