class RemoveRakingFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :raking
  end

  def self.down
    add_column :users, :raking, :integer
  end
end