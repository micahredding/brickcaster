class AddPublishDateToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :publish_date, :datetime
  end
end
