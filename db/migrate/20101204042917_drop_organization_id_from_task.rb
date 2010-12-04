class DropOrganizationIdFromTask < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :organization_id
  end

  def self.down
    add_column  :tasks, :organization_id
  end
end
