class ChangeVideosTable < ActiveRecord::Migration
  def change
    add_column :videos, :yt_count, :string, null: false, default: "no data available"
    add_column :videos, :yt_title, :string, null: false, default: "no data available"
    add_column :videos, :yt_description, :string, null: false, default: "no data available"
    add_column :videos, :yt_author, :string, null: false, default: "no data available"
    add_column :videos, :yt_pub_date, :string, null: false, default: "no data available"
  end
end
