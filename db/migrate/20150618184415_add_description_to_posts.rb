class AddDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :blogit_posts, :description, :text
  end
end
