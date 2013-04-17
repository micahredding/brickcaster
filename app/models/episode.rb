class Episode < ActiveRecord::Base
  belongs_to :podcast
  attr_accessible :body, :episode_number, :media_url, :title, :podcast_id
end
