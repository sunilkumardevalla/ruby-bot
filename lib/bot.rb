require 'telegram/bot'
require_relative 'music'

# rubocop:disable Lint/LiteralInInterpolation
# main class Bot
class Bot
  def initialize
    @token = '1682878047:AAF3ggkgyy6iF1La72qk4RC8pS8qETNHLts'
    @music = Music.new
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |option|
        case option.text
        when '/help'
          bot.api.send_message(chat_id: option.chat.id, text: @music.sentences['commands'])
        when '/start'
          bot.api.send_message(chat_id: option.chat.id, text: @music.sentences['start_message'])
        when '/music'
          music
        when '/stop'
          kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
          bot.api.send_message(chat_id: option.chat.id, text: @music.sentences['stop_message'], reply_markup: kb)
        else
          bot.api.send_message(chat_id: option.chat.id, text: @music.sentences['wrong_entry'])
        end
      end
    end
  end

  def music
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when '/music'
          answers = Telegram::Bot::Types::ReplyKeyboardMarkup
            .new(keyboard: [%w[Romantic Techno], %w[Rock Hip-Hop]], one_time_keyboard: true)
          bot.api.send_message(chat_id: message.chat.id, text: 'Select your choice from Below', reply_markup: answers)
        when 'Romantic'
          bot.api.send_message(chat_id: message.chat.id, text: @music.music_select(@music.romantic))
        when 'Techno'
          bot.api.send_message(chat_id: message.chat.id, text: @music.music_select(@music.techno))
        when 'Rock'
          bot.api.send_message(chat_id: message.chat.id, text: @music.music_select(@music.rock))
        when 'Hip-Hop'
          bot.api.send_message(chat_id: message.chat.id, text: @music.music_select(@music.hiphop))
        else
          initialize
        end
      end
    end
  end
end
# rubocop:enable Lint/LiteralInInterpolation
