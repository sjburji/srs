class RemoveSaltAndPasswordFromUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :salt
  	remove_column :users, :encrypted_password
  end

  def self.down
  	add_column :users, :salt, :string
  	add_column :users, :encrypted_password, :string
  end
end
