require 'telegram/bot'

namespace :telegram_bot do
  task run: :environment do
    Telegram::Bot::Client.run(ENV['telegram_token']) do |bot|
      bot.listen do |message|
        case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} #{message.chat.id}")
          when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        end
      end
    end    
  end
end