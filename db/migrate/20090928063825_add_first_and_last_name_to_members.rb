class AddFirstAndLastNameToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :first_name, :string
    add_column :members, :last_name, :string
    remove_column :members, :name
  end

  def self.down
    remove_column :members, :last_name
    remove_column :members, :first_name
    add_column :members, :name, :string
  end
end
