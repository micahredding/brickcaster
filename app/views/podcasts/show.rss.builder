xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link podcast_url

    for episode in @podcast.episodes
      xml.item do
        xml.title episode.title
        xml.description episode.body
        xml.pubDate 's' # episode.posted_at.to_s(:rfc822)
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end