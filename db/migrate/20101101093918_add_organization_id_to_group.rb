class AddOrganizationIdToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :organization_id, :integer
  end

  def self.down
    drop_column :groups, :organization_id
  end
end
