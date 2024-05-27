class Applications::UpdateChatCount
  include Interactor

  def call
    count_results = Application.joins(:chats).group(:application_id).count

    Application.find_in_batches do |applications|
      upserted_applications = applications.each_with_object([]) do |application, memo|
        attributes_hash = application.attributes.with_indifferent_access
        memo << attributes_hash.merge(chats_count: count_results[application.id])
      end
  
      Application.import upserted_applications, on_duplicate_key_update: [:chats_count]
    end
  end
end