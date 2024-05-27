class Chat::UpdateMessageCount
  include Interactor

  def call
    count_results = Chat.joins(:messages).group(:chat_id).count

    Chat.find_in_batches do |chats|
      upserted_chats = chats.each_with_object([]) do |chat, memo|
        attributes_hash = chat.attributes.with_indifferent_access
        memo << attributes_hash.merge(message_count: count_results[chat.id],)
      end
  
      Chat.import upserted_chats, on_duplicate_key_update: [:message_count]
    end
  end
end