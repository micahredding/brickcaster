xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.title
    xml.description @podcast.body
    xml.link podcast_url(@podcast)

    @podcast.episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.description episode.body
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
        xml.channel.itunes_author 'hi'
      end
    end
  end
end