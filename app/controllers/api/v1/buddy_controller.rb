class Api::V1::BuddyController < Api::ApiController
  include BuddyHelper
  include TelegramHelper
  
  def create
    status = params[:status]
    if status
      json = MultiJson.load(request.body.read, symbolize_keys: true)
      message = get_message(json, status)
      send_message(message)
    end
    head :no_content
  end
end