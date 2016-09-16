module BuddyHelper
  def get_message(json)
    project_name = json[:project][:name]
    execution_url = json[:execution][:url]
    execution_status = json[:execution][:status]
    execution_status = (execution_status == 'INPROGRESS' ? 'SUCCESSFUL' : execution_status)
    execution_branch_name = json[:execution][:branch][:name]
    invoker_name = json[:invoker][:name]
    execution_to_revision_message = json[:execution][:to_revision][:message].strip
    execution_to_revision_url = json[:execution][:to_revision][:url]
    
    message = "[#{project_name}] #{invoker_name} push in '#{execution_to_revision_message}' commit to #{execution_branch_name} branch and the build is #{execution_status}.\n\n"
    message
  end
end