require 'telegram/bot'

module ActivityHelper
  def get_message(json)
    project_id        = json[:project][:id]
    project_name      = json[:project][:name]
    username          = json[:performed_by][:initials]
    highlight         = json[:highlight].tr(':', '')
    primary_resource  = json[:primary_resources][0]
    story_type        = primary_resource[:story_type]
    story_name        = primary_resource[:name]
    url               = primary_resource[:url]
    who_did_it        = "[#{project_name}] #{username} #{highlight}"
    
    case json[:kind]
      when 'story_create_activity'
        "#{who_did_it} new #{story_type} \"#{story_name}\"."
      when 'story_update_activity', 'story_delete_activity'
        return if highlight == 'estimated' || 
                  highlight == 'finished'  || 
                  highlight == 'delivered' || 
                  highlight == 'delivered'
        if highlight == "edited"
          description = json[:changes][0][:new_values][:description]
          "#{who_did_it} description to \"#{description}\" of #{story_type} \"#{story_name}\"."          
        else
          "#{who_did_it} #{story_type} \"#{story_name}\"."
        end
      when 'comment_create_activity' || 'comment_update_activity'
        text = json[:changes][0][:new_values][:text]
        "#{who_did_it} \"#{text}\" to #{story_type} \"#{story_name}\"."
      when 'task_update_activity', 'story_delete_activity'
        s = json[:message].index('"')
        task_name = json[:message][s..-1]
        "#{who_did_it} #{task_name} of #{story_type} \"#{story_name}\"."        
      when 'epic_create_activity'
        "#{who_did_it} new #{primary_resource[:kind]} \"#{story_name}\"."
      else
        logger.info("App -- Undefined kind : #{json}")
        return
    end
  end
  
  def send_message(message)
    Telegram::Bot::Client.run(ENV['telegram_token']) do |bot|
      bot.api.send_message(chat_id: ENV['telegram_chat_id'], text: message)
    end 
  end
end