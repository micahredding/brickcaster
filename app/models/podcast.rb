class Podcast < ActiveRecord::Base
  has_many :episodes
  attr_accessible :shortname, :title, :author, :body, :art_url, :art_url_medium,
  :links, :subscribe_itunes_link, :subscribe_feedburner_link, :keywords, :categories

  def domain
    'http://brickcaster.com'
    'http://localhost:3000'
  end

  def media_directory
    'public/brickcaster.resources'
  end

  def path
    '/' + shortname
  end

  def url
    domain + path
  end

  def rss_path 
    path + '/feed'
  end

  def rss_url
    domain + rss_path
  end

  def media_path
    media_directory + path
  end    

  def subscribe_links
    subscribe_links_hash = {}
    subscribe_links_hash['Subscribe in iTunes'] = subscribe_itunes_link
    subscribe_links_hash['Subscribe in RSS'] = rss_url
    # subscribe_links_hash['Subscribe in Feedburner'] = subscribe_feedburner_link

    string = ""
    subscribe_links_hash.each do 
      |key, value|
      string += "<a href='#{value}'>#{key}</a>"
    end

    string
  end

end
