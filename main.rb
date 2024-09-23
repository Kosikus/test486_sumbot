require 'telegram/bot'
require 'dotenv'

# Загрузка переменных окружения (значение Token)
Dotenv.load

TOKEN = ENV['TELEGRAM_BOT_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  puts "Бот \"test486_sumbot\" запущен!"

  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Привет! Я бот, который может вычислить сумму двух чисел. Введите два числа через пробел.")
    else
      # Попытка распарсить два числа из сообщения
      numbers = message.text.split.map(&:to_f)

      if numbers.size == 2
        sum = numbers[0] + numbers[1]
        bot.api.send_message(chat_id: message.chat.id, text: "Сумма: #{sum}")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Пожалуйста, введите два числа через пробел. Например: 5 7")
      end
    end
  end
end
