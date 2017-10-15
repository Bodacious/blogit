class Blogit::Parsers::MarkdownParser

  require "nokogiri"
  require "blogit/renderers"

  # A String containing the content to be parsed
  attr_reader :content

  def initialize(content)
    @content = content
  end

  # The parsed content
  #
  # Returns an HTML safe String
  def parsed
    markdown.render(content).html_safe
  end


  private


  # The Redcarpet renderer to use
  def renderer
    if Blogit::configuration.highlight_code_syntax
      Blogit::Renderers.choose_highlight_renderer
    else
      Redcarpet::Render::HTML
    end
  end

  # The Redcarpet Markdown handler
  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer,
      Blogit.configuration.redcarpet_options)
  end

  # Check if an executable exists in the load path
  #
  # Returns nil if no executable is found
  def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each do |ext|
        exe = File.join(path, "#{cmd}#{ext}")
        return exe if File.executable? exe
      end
    end
    return nil
  end

end
