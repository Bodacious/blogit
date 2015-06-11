module Blogit
  module ApplicationHelper

    TIMETAG_FORMAT = "%Y-%m-%dT%TZ"
  

    # Creates a div tag with class 'blog_' + (post|comment) + '_' + name
    # Eg:
    #   blog_tag(:title, "") # => <div class="blog_post_title"></div>
    #   blog_tag(:email, "", {:type => "comment"}) # => <div class="blog_comment_email"></div>
    #   blog_tag(:tweet, "", {:type => "status"}) # => <div class="blog_status_tweet"></div>
    def blog_tag(name, content_or_options = {}, options = {}, &block)
      tag_type = options.delete(:type) || "post"

      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = Array(options[:class]) + ["blog_#{tag_type}_#{name}"]
      content_tag(name, content, options)
    end

    # Format content using the {Blogit::Configuration#default_parser_class default_parser_class}
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      parser = Blogit::configuration.default_parser_class.new(content)
      parser.parsed.html_safe
    end

    # Returns the first error message for an ActiveRecord model instance
    # @param object A model instance to check
    # @param attribute A symbol or string for attribute name to check for
    #   errors
    def errors_on(object, attribute)
      error_message = object.errors[attribute].first
      content_tag(:span, error_message, class: "blogit_error_message") if error_message
    end

    # A helper method for creating a +<div>+ tag with class 'field'
    # Used for separating form fields
    def field(content_or_options={}, options ={}, &block)
      div_with_default_class(:field, content_or_options, options, &block)
    end

    # A helper method for creating a +<div>+ tag with class 'actions'
    # Used for option links and form buttons
    def actions(content_or_options={}, options ={}, &block)
      div_with_default_class(:actions, content_or_options, options, &block)
    end

    # A helper method for creating a +<div>+ tag with class 'login_required'
    # Will only render content if there is a logged in user
    def login_required(content_or_options={}, options ={}, &block)
      if current_blogger and blogit_conf.include_admin_links
        div_with_default_class(:login_required, content_or_options, options, &block)
      end
    end


    private


    def div_with_default_class(default_class, content_or_options={}, options={}, &block)
      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = "#{default_class} #{options[:class]}".strip
      content_tag(:div, content, options)
    end

  end
end
