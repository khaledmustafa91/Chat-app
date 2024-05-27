# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.integer :chats_count, default: 0
      t.timestamps
    end
    add_index :applications, :name, unique: true
    add_index :applications, :token, unique: true
  end
end
