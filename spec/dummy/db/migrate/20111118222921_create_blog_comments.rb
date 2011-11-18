class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :website
      t.text :body, null: false
      t.references :post, null: false
      t.string :state

      t.timestamps
    end
    add_index :blog_comments, :post_id
  end
end
