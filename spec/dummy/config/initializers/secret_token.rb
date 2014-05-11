# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.version =~ /\A3/
  Dummy::Application.config.secret_token = 'f72bc586e221e4d19f9746f9a4ca38a75cce2deaabf584fb378e5f30e0c226e14dbb8245befed1060092c74d2e6804a50a531c351f994b7a10edf2bdbd6fbefd'
else
  Dummy::Application.config.secret_key_base = 'f72bc586e221e4d19f9746f9a4ca38a75cce2deaabf584fb378e5f30e0c226e14dbb8245befed1060092c74d2e6804a50a531c351f994b7a10edf2bdbd6fbefd'  
end
