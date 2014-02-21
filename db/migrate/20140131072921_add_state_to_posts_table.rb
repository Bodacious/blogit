class AddStateToPostsTable < ActiveRecord::Migration
  def change
    add_column(:blogit_posts, :state, :string, null: false, default: Blogit::configuration.hidden_states.first.to_s)
  end
end
