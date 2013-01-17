# FIXME: These specs are broken
# Fix when you have a minute
#
# require "spec_helper"
# 
# describe PostsController do
#   
#   describe "routing" do
#     
#     before do
#       # Use blogit's routes instead
#       @routes = Blogit::Engine.routes
#     end
#     
#     it "routes /posts/page/:page to posts#index with page param" do
#       { get: "posts/page/2" }.should route_to({
#         controller: "blogit/posts",
#         action: "index",
#         page: "2"
#       })
#     end
#     
#     it "routes /posts/tagged/:tag to posts#tagged with tag param" do
#       { get: "posts/tagged/Spiceworld" }.should route_to({
#         controller: "blogit/posts",
#         action: "tagged",
#         tag: "Spiceworld"
#       })      
#     end
# 
# 
#     describe "when Blogit.configuration.include_admin_actions is true" do
# 
#       before do
#         Blogit.configuration.include_admin_actions = true
#       end
#       
#     end
# 
#     describe "when Blogit.configuration.include_admin_actions is false" do
# 
#       before do
#         Blogit.configuration.include_admin_actions = false 
#       end
# 
#     end
# 
#   end
# end
