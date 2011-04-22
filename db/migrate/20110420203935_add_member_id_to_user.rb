class AddMemberIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :member_id, :integer
  end

  def self.down
    remove_column :users, :member_id
  end
end
