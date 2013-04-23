xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.title
    xml.link @podcast.podcast_url
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
      xml.itunes_category :text => 'Category 2'
    end
    xml.itunes_keywords 'singularity,technology,transhuman,transhumanism,kurzweil,artificial,intelligence,technium,kevin,kelly'

    @podcast.episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.itunes_author episode.author || @podcast.author || 'Micah Redding'
        xml.itunes_subtitle truncate(episode.body, :length => 255, :separator => "\n")
        xml.description episode.body
        xml.itunes_summary episode.body
        xml.itunes_image @podcast.art_url
        xml.enclosure :url => episode.media_url
        xml.guid episode.episode_url
        xml.link episode.episode_url
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.itunes_duration '10:00'
      end
    end
  end
end