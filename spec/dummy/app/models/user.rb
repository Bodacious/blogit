class User < ApplicationRecord
  # this is where the magic happens
  blogs

  # Find the User by username and password
  def self.authenticate(attribute_hash)
    find_by(username: attribute_hash[:username], password: attribute_hash[:password])
  end
end
