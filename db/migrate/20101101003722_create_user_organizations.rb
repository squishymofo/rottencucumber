class CreateUserOrganizations < ActiveRecord::Migration
  def self.up
    create_table :user_organizations do |t|
      t.integer :organization_id
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :user_organizations
  end
end
