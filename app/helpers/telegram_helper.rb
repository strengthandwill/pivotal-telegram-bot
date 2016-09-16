require 'telegram/bot'

module TelegramHelper
  def send_message(message)
    Telegram::Bot::Client.run(ENV['telegram_token']) do |bot|
      bot.api.send_message(chat_id: ENV['telegram_chat_id'], text: message, disable_web_page_preview: true)
    end 
  end
end