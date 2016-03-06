require 'telegram/bot'

module ActivityHelper
  def get_message(json)
    project_id        = json[:project][:id]
    project_name      = json[:project][:name]
    username          = json[:performed_by][:name]
    highlight         = json[:highlight].tr(':', '')
    primary_resource  = json[:primary_resources][0]
    story_type        = primary_resource[:story_type]
    story_name        = primary_resource[:name]
    url               = primary_resource[:url]
    who_did_it        = "[#{project_name}] #{username} #{highlight}"

    case json[:kind]
      when 'story_create_activity'
        "#{who_did_it} new #{story_type} \"#{story_name}\". See: #{url}"
      when 'story_update_activity', 'story_delete_activity'
        return if highlight == 'estimated'
        "#{who_did_it} #{story_type} \"#{story_name}\". See: #{url}"
      when 'comment_create_activity'
        "#{who_did_it} to the #{story_type} \"#{story_name}\". See: #{url}"
      when 'epic_create_activity'
        "#{who_did_it} new #{primary_resource[:kind]} \"#{story_name}\". See: #{url}"
      else
        PivotalTracker::Base.logger.info("App -- Undefined kind : #{json}")
        return
    end
  end
  
  def send_message(message)
    p ENV['telegram_token']
    p ENV['telegram_chat_id']
    Telegram::Bot::Client.run(ENV['telegram_token']) do |bot|
      bot.api.send_message(chat_id: ENV['telegram_chat_id'], text: message)
    end 
  end
end