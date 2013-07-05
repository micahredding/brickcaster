xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.title
    xml.link podcast_show_url(@podcast.shortname)
    xml.itunes_subtitle truncate(@podcast.body, :length => 255, :separator => "\n") 
    xml.description @podcast.body
    xml.itunes_summary @podcast.body
    xml.language 'en-us'
    xml.copyright 'copyright © 2013 Micah Redding'
    xml.itunes_author @podcast.author || 'Micah Redding'
    xml.itunes_owner do
      xml.itunes_name 'Micah Redding'
      xml.itunes_email 'micahtredding@gmail.com'
    end
    xml.itunes_image :href => @podcast.art_url
    @podcast.categories.lines.each do |category|
      xml.itunes_category :text => category.chomp
    end
    xml.itunes_keywords @podcast.keywords

    episodes = @podcast.episodes
    episodes.sort_by! { |e| e.publish_date.to_i }
    episodes.reverse!

    episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.itunes_author episode.author || @podcast.author || 'Micah Redding'
        xml.itunes_subtitle truncate(episode.body, :length => 255, :separator => "\n")
        xml.description raw BlueCloth.new(episode.body).to_html
        xml.itunes_summary raw BlueCloth.new(episode.body).to_html
        xml.itunes_image @podcast.art_url
        xml.enclosure :url => episode.media_url, :length => episode.media_filesize
        xml.guid episode_show_url(@podcast.shortname, episode.episode_number)
        xml.link episode_show_url(@podcast.shortname, episode.episode_number)
        xml.pubDate episode.publish_date_formatted
        xml.itunes_duration episode.media_length_formatted
      end
    end
  end
end
