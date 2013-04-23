class Podcast < ActiveRecord::Base
  has_many :episodes
  attr_accessible :shortname, :title, :author, :body, :art_url, :links, :subscribe_itunes_link, :subscribe_feedburner_link

  def rss_path 
    shortname + '.rss'
  end

  def podcast_url
    'http://localhost:3000/' + shortname
  end

  def subscribe_links
    subscribe_links_hash = {}

    subscribe_links_hash['Subscribe in iTunes'] = subscribe_itunes_link
    subscribe_links_hash['Subscribe in Feedburner'] = subscribe_feedburner_link
    subscribe_links_hash['RSS'] = rss_path

    subscribe_links_hash
  end

  def custom_links
    links_hash_list = {}

    if links
      links.lines.map{ |h| 
        h1,h2 = h.split('|')
        if h1 and h2
          links_hash_list[h1] = h2.chomp!
        end
      }
    end

    links_hash_list
  end

  def links_hash
    links_hash_list = subscribe_links.merge custom_links 
    links_hash_list
  end

  def links_html
    string = ""
    links_hash.each do 
      |key, value|
      string += "<a href='#{value}'>#{key}</a>"
    end
    string
  end

end
