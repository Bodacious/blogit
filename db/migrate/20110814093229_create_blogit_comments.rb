class CreateBlogitComments < ActiveRecord::Migration[7.0]
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
  end
end
