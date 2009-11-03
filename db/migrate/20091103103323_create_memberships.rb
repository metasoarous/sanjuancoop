class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :accepts_newsletters

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
