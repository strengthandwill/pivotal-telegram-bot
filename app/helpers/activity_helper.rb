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
    next_state        = next_state(highlight)
    who_did_it        = "[#{project_name}] #{username} #{highlight}"
    
    case json[:kind]
      # when 'story_create_activity'
        # "#{project_name} #{who_did_it} new #{story_type} \"#{story_name}\".\n#{url}"
        # "[#{project_name}][#{next_state}][#{story_name}][#{story_type} by #{username}][#{url}]"
      when 'story_update_activity', 'story_delete_activity'
        return if highlight == 'estimated' || highlight == "edited"
        # "#{project_name} #{who_did_it}#{next_state} #{story_type} \"#{story_name}\", #{next_state}\n#{url}"
        "[#{project_name}][#{next_state}][#{story_name}][#{story_type} by #{username}][#{url}]"
      else
        logger.info("App -- Undefined kind : #{json}")
        return
    end
  end
  
  def next_state(highlight)
    case highlight
      when "planned"
        "Ready for DEV"      
      when "started"
        "WIP"      
      when "finished"
        "Ready for TESTING"
      when "delivered"
        "Ready for ACCEPTANCE"
      when "accepted"
        "DONE"
      when "rejected"
        "Restarted for DEV"
      else
        ""
    end
  end
end