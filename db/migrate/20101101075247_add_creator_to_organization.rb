class AddCreatorToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :creator_id, :integer
  end

  def self.down
    remove_column :organizations, :creator_id
  end
end
