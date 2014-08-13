class Index
  include BrickcasterHelpers
  attr_accessor :hash, :json

  def initialize args
    @hash = args
    @json = args.to_json
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def podcasts
    @podcasts.collect do |podcast_id|
      Podcast.get(podcast_id)
    end
  end


  def self.get
    filename = 'data/index.json'
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
