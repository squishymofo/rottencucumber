class CreateSmsSessions < ActiveRecord::Migration
  def self.up
    create_table :sms_sessions do |t|
      t.string :phone_number
      t.string :more, :default => ""
      t.integer :task_id

      t.timestamps
    end
    add_index :sms_sessions, :phone_number, :unique => true
  end

  def self.down
    drop_table :sms_sessions
  end
end
