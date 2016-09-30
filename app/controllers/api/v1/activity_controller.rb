class Api::V1::ActivityController < Api::ApiController
  include ActivityHelper
  include TelegramHelper
  
  def create
    json = MultiJson.load(request.body.read, symbolize_keys: true)
    message = get_message(json)
    send_message(message) if message
    head :no_content
  end
end