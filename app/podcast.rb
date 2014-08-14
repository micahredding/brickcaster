class Podcast
  include BrickcasterHelpers
  attr_accessor :title, :podcast_id, :author, :url, :itunes_url, :rss_url, :keywords, :categories, :description, :links

  def initialize args
    @hash = args
    @json = args.to_json
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def art_url key="normal"
      @art_url[key]
  end

  def episodes
    @episodes.collect! do |episode_number|
      Episode.get(@podcast_id, episode_number)
    end
  end

  def local_url
    @url.gsub('http://brickcaster.com', '')
  end

  def self.get id
    filename = "data/podcasts/#{id}.json"
    begin
      File.open(filename, "r") do |f|
        self.new JSON.load( f )
      end
    rescue
      puts filename
      nil
    end
  end

end

