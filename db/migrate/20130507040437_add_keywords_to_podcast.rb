class AddKeywordsToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :keywords, :string
  end
end
