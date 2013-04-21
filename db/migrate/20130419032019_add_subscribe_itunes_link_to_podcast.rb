class AddSubscribeItunesLinkToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :subscribe_itunes_link, :string
  end
end
