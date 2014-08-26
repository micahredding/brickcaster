require 'redcarpet'

module BrickcasterHelpers
  def markdown
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:link_attributes => Hash["target" => "_blank"]),
      :hard_wrap => true,
      :autolink => true,
      :space_after_headers => true
    )
  end

  def local_url
    url.gsub('http://brickcaster.com', '')
  end

  def format_length(length)
    if length.nil?
      return "00:00:00"
    end
    length = Time.at(length.to_i).utc.strftime("%H:%M:%S")
  end

  def format_date(date)
    return 0 if date.nil?
    DateTime.parse(date).rfc822
  end

  def format_date_human(date)
    return 0 if date.nil?
    Date.parse(date).strftime("%Y.%m.%d")
  end
end
