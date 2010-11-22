class AddSmsStuffToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sms_enabled, :boolean, :default => false
    add_column :users, :phone_number, :string
    add_index :users, :phone_number
  end

  def self.down
    remove_column :users, :phone_number
    remove_column :users, :sms_enabled
  end
end
