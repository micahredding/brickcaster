class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :shortname
      t.string :title
      t.text :body
      t.text :links
      t.string :art_url

      t.timestamps
    end
  end
end
