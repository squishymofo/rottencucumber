class ChangeProjectDescriptionToText < ActiveRecord::Migration
  def self.up
    change_column :projects, :description, :text
  end

  def self.down
    change_column :projects, :description, :string
  end
end
