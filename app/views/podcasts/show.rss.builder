xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.title
    xml.link podcast_show_path(@podcast.shortname)
    xml.itunes_subtitle truncate(@podcast.body, :length => 255, :separator => "\n") 
    xml.description @podcast.body
    xml.itunes_summary @podcast.body
    xml.language 'en-us'
    xml.copyright '&#169; 2013 Micah Redding'
    xml.itunes_author @podcast.author
    xml.itunes_owner do
      xml.itunes_name 'Micah Redding'
      xml.itunes_email 'micahtredding@gmail.com'
    end
    xml.itunes_image @podcast.art_url
    xml.itunes_category do
      @podcast.categories.lines.each do |category|
        xml.itunes_category :text => category.chomp
      end
    end
    xml.itunes_keywords @podcast.keywords

    @podcast.episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.itunes_author episode.author || @podcast.author || 'Micah Redding'
        xml.itunes_subtitle truncate(episode.body, :length => 255, :separator => "\n")
        xml.description raw BlueCloth.new(episode.body).to_html
        xml.itunes_summary raw BlueCloth.new(episode.body).to_html
        xml.itunes_image @podcast.art_url
        xml.enclosure :url => episode.media_url
        xml.guid episode_show_path(@podcast.shortname, episode.episode_number)
        xml.link episode_show_path(@podcast.shortname, episode.episode_number)
        xml.pubDate episode.publish_date || episode.created_at.to_s(:rfc822)
        xml.itunes_duration episode.media_length || 0
      end
    end
  end
end