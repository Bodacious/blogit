class User < ActiveRecord::Base

  # this is where the magic happens
  blogs
  
  # Find the User by username and password
  def self.authenticate(attribute_hash)
    find_by_username_and_password(attribute_hash[:username], attribute_hash[:password])
  end
  
end
