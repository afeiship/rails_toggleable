class AddActiveToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :active, :boolean, default: true
    # Consider adding an index if you frequently query by this field
    # add_index :users, :active
  end
end
