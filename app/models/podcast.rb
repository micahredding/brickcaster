class Podcast < ActiveRecord::Base
  has_many :episodes
  attr_accessible :shortname, :title, :author, :body, :art_url, :art_url_medium, :art_url_wide,
  :links, :subscribe_itunes_link, :subscribe_feedburner_link, :keywords, :categories

end
