module BuddyHelper
  def get_message(json, status)
    project_name = json[:project][:name]
    execution_url = json[:execution][:url]
    execution_branch_name = json[:execution][:branch][:name]
    invoker_name = json[:invoker][:name]
    execution_to_revision_message = json[:execution][:to_revision][:message].strip
    execution_to_revision_html_url = json[:execution][:to_revision][:html_url]
    message =  "[Buddy CI] Build status is #{status.upcase} for '#{execution_to_revision_message}' commit:\n"
    message += execution_to_revision_html_url
    message
  end
end