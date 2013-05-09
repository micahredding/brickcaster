class AddArtUrlMediumToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :art_url_medium, :string
  end
end
