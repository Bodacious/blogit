module Blogit
  module ApplicationHelper
    
    TIMETAG_FORMAT = "%Y-%m-%dT%TZ"
    
    def errors_on(object, attribute)
      object.errors[attribute].first.to_s
    end
    
    def field(content_or_options={}, options ={}, &block)
      div_with_default_class(:field, content_or_options, options, &block)
    end
    
    def actions(content_or_options={}, options ={}, &block)
      div_with_default_class(:actions, content_or_options, options, &block)
    end
    
    def login_required(content_or_options={}, options ={}, &block)
      div_with_default_class(:login_required, content_or_options, options, &block) if current_blogger
    end
    
    def time_tag(time_object, format = nil, options ={})
      # if there's a specified format and it's a string, assume it's an strftime string
      if format && format.is_a?(String)
        time_string = time_object.strftime(format)
      # if there's a specified format and it's a symbol, assume it's a predefined format
      elsif format && format.is_a?(Symbol)
        time_string = time_object.to_s(format)
      else
        time_string = time_object.to_s
      end
      options.merge(datetime: time_object.strftime(TIMETAG_FORMAT))
      content_tag(:time, time_string, options)
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
