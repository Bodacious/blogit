module Blogit
  module ApplicationHelper
    
    # Format content using the {Blogit::Configuration#default_parser_class default_parser_class}
    #
    # content - A String containing the content to be formatted (defaults: nil)
    # block   - A Proc that returns a String of content to be formatted
    #
    # Examples
    # 
    #   format_content("# This is a Markdown header")
    #   # => "<h1>This is a Markdown header</h1>"
    #
    #   format_content do 
    #     "some text"
    #   end
    #   # => "<p>some text</p>"
    #
    # Returns an HTML safe String.
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      parser  = Blogit::configuration.default_parser_class.new(content)
      parser.parsed.to_s.html_safe
    end

    # The first error message for an ActiveRecord::Base model instance attribute
    #
    # object    - An ActiveRecord::Base instance to check
    # attribute - A Symbol or String with the attribute name to check errors on
    #
    # Examples
    #
    #  errors_on(@user, :first_name)
    #  # => "Can't be blank"
    #
    # Returns a String with the error message
    def errors_on(object, attribute)
      error_message = object.errors[attribute].first
      content_tag(:span, error_message, class: "blogit_error_message") if error_message
    end

    # A helper method for creating a div tag with class 'field'. Used for separating
    # form fields.
    #
    # content_or_options - The content to include in the div when not using a block. The
    #                      options Hash when using a block
    # options            - The options when not using a block
    # block              - A block that returns HTML content to include in the div
    #
    # Returns an HTML safe String
    def field(content_or_options = {}, options ={}, &block)
      div_tag_with_default_class("field", content_or_options, options, &block)
    end

    # A helper method for creating a div tag with class 'actions'. Used as a wrapper
    # for form actions.
    #
    # content_or_options - The content to include in the div when not using a block. The
    #                      options Hash when using a block
    # options            - The options when not using a block
    # block              - A block that returns HTML content to include in the div
    #
    # Returns an HTML safe String
    def actions(content_or_options={}, options ={}, &block)
      div_tag_with_default_class("actions", content_or_options, options, &block)
    end
    
    
    private
    
    
    # Creates an HTML div with a default class value added
    #
    # default_class      - The CSS class name to add to the div
    # content_or_options - The content to include in the div when not using a block. The
    #                      options Hash when using a block
    # options            - The options when not using a block
    # block              - A block that returns HTML content to include in the div
    #
    #
    # Returns an HTML safe String
    def div_tag_with_default_class(default_class, content_or_options, options, &block)
      if block_given?
        options = content_or_options
        content = capture(&block)
      else
        content = content_or_options
      end
      options[:class] = Array(options[:class]) + [default_class]
      content_tag(:div, content, options)
    end

  end
  
end