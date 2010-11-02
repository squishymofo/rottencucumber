class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text  :description
      t.datetime :due
      t.integer :point
      t.integer :group_id
      t.integer :project_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tasks
  end
end
