module BuddyHelper
  def get_message(json)
    project_name = json[:project][:name]
    execution_url = json[:execution][:url]
    execution_status = json[:execution][:status]
    execution_status = (execution_status == 'INPROGRESS' ? 'SUCCESSFUL' : execution_status)
    execution_branch_name = json[:execution][:branch][:name]
    execution_creator_name = json[:execution][:creator][:name]
    execution_to_revision_message = json[:execution][:to_revision][:message]
    execution_to_revision_url = json[:execution][:to_revision][:url]
    
    message =  "[#{project_name}] #{execution_creator_name} push in '#{execution_to_revision_message}' commit to #{execution_branch_name} branch and the build is #{execution_status}.\n\n"
    message += "Commit url: #{execution_to_revision_url}\n\n"
    message += "Build url: #{execution_url}"
  end
end