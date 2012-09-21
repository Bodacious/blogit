module Blogit
  class Comment < ActiveRecord::Base
    
    # require custom validators
    require "validators"
    include Validators
    
    self.table_name = "blog_comments"
    
    # ================
    # = Associations =
    # ================
    
    belongs_to :post, class_name: "Blogit::Post", 
      foreign_key: "post_id", counter_cache: true, touch: true
    
    # TODO: Check if this is optimal
    URL_REGEX   = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

    # TODO: Check if this is optimal    
    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
    
    # ============
    # = Callbacks =
    # ============
    
    before_validation :format_website
    
    # ==============
    # = Attributes =
    # ==============
    
    attr_accessible :name, :nickname, :email, :body, :website
    
    # nickname acts as a "honeypot" to catch spam
    # the form field should be hidden using CSS and so 
    # if present, must be spam.
    # 
    # @attribute
    attr_accessor :nickname
    
    
    # ===============
    # = Validations =
    # ===============

    # nickname acts as a "honeypot" to catch spam
    # the form field should be hidden using CSS and so 
    # if present, must be spam.
    validates :nickname, absence: true
    validates :name, presence: true
    validates :email, presence: true, format: {with: EMAIL_REGEX, allow_blank: true }
    validates :body, presence: true, length: { minimum: 4, allow_blank: true}
    validates :website, format: {with: URL_REGEX, allow_blank: true}
        
  private
    
    # Prepend http to the url before the validation check
    def format_website
      if self.website.present? and self.website !~ /^http/i
        self.website = "http://#{self.website}"
      end
    end
    
  end
end