class AddFinishedByIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :finished_by_id, :integer
  end

  def self.down
    remove_column :tasks, :finished_by_id
  end
end
