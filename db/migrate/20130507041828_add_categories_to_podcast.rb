class AddCategoriesToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :categories, :text
  end
end
