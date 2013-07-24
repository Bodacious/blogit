# create a custom renderer that allows highlighting of code blocks
class Redcarpet::Render::HTMLWithPygments < Redcarpet::Render::HTML

  def block_code(code, language)
    require "pygments"
    Pygments.highlight(code, lexer: language)
  end

end
