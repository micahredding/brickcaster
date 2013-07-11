class AddSummaryToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :summary, :text
  end
end
