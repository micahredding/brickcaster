class AddMediaSizeToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :media_size, :string
  end
end
