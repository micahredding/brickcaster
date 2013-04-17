class Podcast < ActiveRecord::Base
  has_many :episodes
  attr_accessible :art_url, :body, :links, :title, :shortname
end
