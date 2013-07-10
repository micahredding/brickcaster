class AddMediaSizeToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :media_size, :number
  end
end
