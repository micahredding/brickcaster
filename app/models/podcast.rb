class Podcast < ActiveRecord::Base
  has_many :episodes
  attr_accessible :art_url, :body, :links, :title, :shortname

  def rss_path 
    shortname + '.rss'
  end

  def links_hash
    links_hash_list = links.lines.map{ |h| 
      h1,h2 = h.split('|')
      {h1 => h2.chomp!}
    }.reduce(:merge)

    links_hash_list['RSS'] = rss_path

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
