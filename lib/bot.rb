# frozen_string_literal: true

require 'telegram/bot'
require_relative 'messages.rb'

class Bot
  def initialize
    @token = '1631929196:AAFj5IPu_d83nMnodtwiaq_thFgip854QaU'
    @commands = Messages.new
    Telegram::Bot::Client.run(@token) do |bot|
    bot.listen do |reply|
      case command
        when /start/i
          reply.text = 'All I can do is say hello. Try the /greet command.'
        when /greet/i
          greetings = %w[bonjour hola hallo sveiki namaste salaam szia halo ciao]
          reply.text = "#{greetings.sample.capitalize}, #{message.from.first_name}!"
        else
          reply.text = "I have no idea what #{command.inspect} means."
        end
          puts "sending #{reply.text.inspect} to @#{message.from.username}"
          reply.send_with(bot)
        end
      end
  end
end
