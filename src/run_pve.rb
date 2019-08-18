# frozen_string_literal: true

def build_map_str(map)
  str = ' '
  (0..2).each do |i|
    (0..2).each do |j|
      str += case map[i, j]
             when 0
               "◻️ "
             when 1
               "❎ "
             when 2
               "🅾️ "
             else
               'something went really wrong'
             end
      str += '| ' if j != 2
    end
    str += "\n"
    str += "—   +  —  +  —\n" if i != 2
  end
  str
end

def show_game_field(bot, message, map)
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(1 2 3), %w(4 5 6), %w(7 8 9)])
  bot.api.send_message(chat_id: message.chat.id, text: build_map_str(map), reply_markup: answers)
end

def run_pve(bot, map, easy_bot)
  bot.listen do |message|
    case message.text
    when 'Ready'
      easy_bot.easy_move(map) if easy_bot.read_figure == 1
      show_game_field(bot, message, map)
      break
    when '/stop'
      stop(bot, message)
    when '/restart'
      start_again(bot, message)
    else
      say_unknown_command(bot, message)
    end
  end
end