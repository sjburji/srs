class AddTabToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :tab_id, :integer
  end

  def self.down
    remove_column :posts, :tab_id
  end
end
