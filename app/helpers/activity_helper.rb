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
    next_state        = next_state(highlight)
    who_did_it        = "[#{project_name}] #{username} #{highlight}"
    
    case json[:kind]
      when 'story_move_activity', 'story_update_activity'
        return if highlight == 'estimated' || highlight == 'edited' || highlight == 'moved'
        "#{project_name} >> #{next_state}\n#{story_name}\n#{highlight.capitalize} by #{username}\n#{url}"
      else
        logger.info("App -- Undefined kind : #{json}")
        return
    end
  end
  
  def next_state(highlight)
    case highlight
      when 'unstarted'
        'Ready for DEV'
      when 'moved and scheduled'
        'Ready for DEV'      
      when 'started'
        'WIP'      
      when 'finished'
        'Ready for TESTING'
      when 'delivered'
        'Ready for ACCEPTANCE'
      when 'accepted'
        'ᕕ( ᐛ )ᕗ DONE!'
      when 'rejected'
        'Restarted for DEV'
      else
        ''
    end
  end
end