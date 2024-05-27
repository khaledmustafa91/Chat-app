# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :chat_number, null: false
      t.integer :message_count, default: 0
      t.belongs_to :application
      t.timestamps
    end
    add_index :chats, %i[chat_number application_id], unique: true
  end
end
