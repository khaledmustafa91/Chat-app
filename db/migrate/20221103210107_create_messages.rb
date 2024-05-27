# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :message_number, null: false
      t.belongs_to :chat
      t.timestamps
    end
    add_index :messages, [:chat_id, :message_number], unique: true
  end
end
