# frozen_string_literal: true

def when_yes(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: 'Great!', reply_markup: kb)
  question = 'Do you want to play for crosses or noughts?'
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
    .new(keyboard: [%w[Crosses], %w[Noughts]], one_time_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
end

def when_no(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  mess = "Sorry to see you go :(\nWrite /restart to run me again."
  bot.api.send_message(chat_id: message.chat.id, text: mess, reply_markup: kb)
end

def say_unknown_command(bot, message)
  mess = 'Do you think it is funny?'
  bot.api.send_message(chat_id: message.chat.id, text: mess)
end

def pre_init(bot)
  bot.listen do |message|
    case message.text
    when 'Yes'
      when_yes(bot, message)
      break
    when 'No'
      when_no(bot, message)
    when '/restart'
      start_again(bot, message)
      break
    else
      say_unknown_command(bot, message)
    end
  end
end
