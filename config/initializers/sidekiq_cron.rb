# frozen_string_literal: true

jobs = [
  {
    'name' => 'update_chat_message_count',
    'class' => 'UpdateChatMessageCountJob',
    'cron' => 'every 1 hour'
  },
  {
    'name' => 'update_application_chat_count',
    'class' => 'UpdateApplicationChatCountJob',
    'cron' => 'every 1 hour'
  }
]
Sidekiq::Cron::Job.load_from_array(jobs)
