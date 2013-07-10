module EpisodesHelper

  def markdown_init
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :hard_wrap => true, :autolink => true, :space_after_headers => true)
  end

  def process_markdown(body)
    markdown = markdown_init
    raw markdown.render(body)
  end

  def body_truncate(body)
    truncate(body, :length => 255, :separator => "\n")
  end

  def body_encode(body)
    process_markdown(body)
  end

  def format_length(length)
    if length.nil?
      return "00:00:00"
    end
    length = Time.at(length.to_i).utc.strftime("%H:%M:%S")
  end

  def format_date(date)
    if date.nil?
      return 0
    end
    date.rfc822
  end

  def format_date_human(date)
    if date.nil?
      return 0
    end
    date.strftime("%Y.%m.%d")
  end

end
