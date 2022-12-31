class AddDescriptionToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blogit_posts, :description, :text
  end
end
