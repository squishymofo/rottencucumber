class CreateUserActions < ActiveRecord::Migration
  def self.up
    create_table :user_actions do |t|
      t.string :ip
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :user_actions
  end
end
