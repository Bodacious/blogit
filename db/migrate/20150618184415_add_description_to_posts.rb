class AddDescriptionToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :blogit_posts, :description, :text
  end
end
