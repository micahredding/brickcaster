class AddArtUrlWideToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :art_url_wide, :string
  end
end
