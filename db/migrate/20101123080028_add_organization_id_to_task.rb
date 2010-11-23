class AddOrganizationIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :organization_id, :integer
  end

  def self.down
    remove_column :tasks, :organization_id
  end
end
