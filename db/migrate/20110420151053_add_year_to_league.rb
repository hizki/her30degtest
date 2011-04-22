class AddYearToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :year, :integer
  end

  def self.down
    remove_column :leagues, :year
  end
end
