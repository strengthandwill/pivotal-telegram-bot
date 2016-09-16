class Api::V1::BuddyController < Api::ApiController
  include BuddyHelper
  include TelegramHelper
  
  def create
    json = MultiJson.load(request.body.read, symbolize_keys: true)
    message = get_message(json)
    send_message(message)
    head :no_content
  end
end