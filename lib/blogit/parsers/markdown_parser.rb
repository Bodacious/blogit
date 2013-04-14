class Blogit::Parsers::MarkdownParser
  
  require "nokogiri"
  require "albino"
  require "blogit/renderers"
    
  def initialize(content)
    @content = content
  end

  def parsed
    ensure_pygments_is_installed if Blogit::configuration.highlight_code_syntax
    
    renderer = Blogit::configuration.highlight_code_syntax ?  Redcarpet::Render::HTMLWithAlbino : Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(renderer, Blogit.configuration.redcarpet_options)
    html_content = markdown.render(@content).html_safe
  end

  private
  
  def ensure_pygments_is_installed
    warning = <<-WARNING
[blogit] The pygmentize command could not be found in your load path!
         Please either do one of the following:

         $ sudo easy_install Pygments # to install it
         
         or 
         
         set config.highlight_code_syntax to false in your blogit.rb config file.
         
WARNING
    raise warning unless which(:pygmentize)
  end
  
  # Check if an executable exists in the load path
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
