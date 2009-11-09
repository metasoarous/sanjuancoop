class AddPhoneNumberAndAcceptsNewslettersToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :phone_number, :string
    add_column :members, :accepts_newsletters, :boolean
  end

  def self.down
    remove_column :members, :phone_number
    remove_column :members, :accepts_newsletters
  end
end
