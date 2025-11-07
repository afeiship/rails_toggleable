class AddPublishedToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :published, :boolean, default: true
    # Consider adding an index if you frequently query by this field
    # add_index :posts, :published
  end
end
