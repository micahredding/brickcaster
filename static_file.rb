require 'redcarpet'
require 'yaml'
require 'erb'
require 'tilt'

class StaticFile
  extend BrickcasterHelpers

  INPUT_ROOT = "source"
  OUTPUT_ROOT = "destination"
  TEMPLATE_ROOT = "views"

  def self.read(input_path)
    file_contents = File.read "#{INPUT_ROOT}/#{input_path}"
    if (md = file_contents.match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m))
      body = self.markdown.render(md.post_match)
      metadata = YAML.load(md[:metadata])
      metadata[:body] = body
    end
    metadata
  end

  def self.render(object, template, variables = {})
    self.render_outer(object, template, variables)
  end

  def self.render_outer(object, template, variables = {})
    layout = Tilt.new("#{TEMPLATE_ROOT}/layout.html.erb")
    content = self.render_inner(object, template, variables)
    layout.render object, variables do
      content
    end
  end

  def self.render_inner(object, template, variables = {})
    template = Tilt.new("#{TEMPLATE_ROOT}/#{template}")
    output = template.render object, variables
  end

  def self.write(output_path, output)
    File.open("#{OUTPUT_ROOT}/#{output_path}", "w") do |f|
      f.write output
    end
  end

end
