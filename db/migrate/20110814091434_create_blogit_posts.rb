class CreateBlogitPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blogit_posts do |t|
      t.with_options(null: false) do |r|
        r.string :title
        r.text :body
        r.string :state, default: Blogit::configuration.hidden_states.first.to_s
        r.integer :comments_count, default: 0
      end
      t.references :blogger, polymorphic: true
      t.timestamps
    end
  end
end
