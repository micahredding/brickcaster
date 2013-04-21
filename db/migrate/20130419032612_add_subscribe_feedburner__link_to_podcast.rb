class AddSubscribeFeedburnerLinkToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :subscribe_feedburner_link, :string
  end
end
