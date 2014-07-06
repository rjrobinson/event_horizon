class MarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText

    # XXX HACK: Redcarpet strips hard tabs out of code blocks,
    # so we assume you're not using leading spaces that aren't tabs,
    # and just replace them here.
    if lexer.tag == "make"
      code.gsub! /^    /, "\t"
    end

    formatter = Rouge::Formatters::HTML.new(css_class: "highlight #{lexer.tag}")

    html_code = formatter.format(lexer.lex(code))
    "<div class='code-block'>#{html_code}</div>"
  end
end
