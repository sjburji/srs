class RemoveSummaryFromPosts < ActiveRecord::Migration
  def up
  	remove_column :posts, :summary
  end

  def down
  	add_column :posts, :summary, :string
  end
end
