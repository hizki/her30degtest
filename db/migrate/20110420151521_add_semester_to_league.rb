class AddSemesterToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :semester, :string
  end

  def self.down
    remove_column :leagues, :semester
  end
end
