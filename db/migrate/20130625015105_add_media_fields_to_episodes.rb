class AddMediaFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :media_length, :number
    add_column :episodes, :media_title, :string
    add_column :episodes, :media_artist, :string
    add_column :episodes, :media_album, :string
    add_column :episodes, :media_year, :number
    add_column :episodes, :media_track, :string
  end
end
