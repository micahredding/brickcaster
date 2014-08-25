module Generator
  def generate
    p = {:podcast_id => 'singularity'}
    p.class.include StaticFileGenerator
    p.write_podcast_html
  end
end
