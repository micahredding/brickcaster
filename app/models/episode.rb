class Episode < ActiveRecord::Base
  belongs_to :podcast
  attr_accessible :episode_number, :title, :author, :body, :media_url, :podcast_id

  def episode_url
    'http://localhost:3000/' + podcast.shortname + '/' + episode_number.to_s
  end

end
