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

  def self.filename id
    "data/podcasts/#{id}.json"
  end

  def self.get id
    begin
      File.open(filename(id), "r") do |f|
        self.new JSON.load( f )
      end
    rescue
      puts filename(id)
      nil
    end
  end

end

