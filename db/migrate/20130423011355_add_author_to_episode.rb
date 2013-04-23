class AddAuthorToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :author, :string
  end
end
