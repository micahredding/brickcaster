class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :body
      t.string :media_url
      t.integer :episode_number
      t.references :podcast

      t.timestamps
    end
    add_index :episodes, :podcast_id
  end
end
