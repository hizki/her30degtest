class AddPlayCountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :play_count, :integer
  end

  def self.down
    remove_column :users, :play_count
  end
end
