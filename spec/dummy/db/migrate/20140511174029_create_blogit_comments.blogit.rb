# This migration comes from blogit (originally 20110814093229)
class CreateBlogitComments < ActiveRecord::Migration
  def change
    create_table :blogit_comments do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :website
      t.text :body, null: false
      t.references :post, null: false
      t.string :state

      t.timestamps
    end
    add_index :blogit_comments, :post_id
  end
end
