require 'discordrb'
require 'rack'

bot_id = ENV['DISCORD_ID']
bot_secret = ENV['DISCORD_SECRET']

bot = Discordrb::Bot.new token: bot_secret, client_id: bot_id

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
  puts "got ping, putting pong"
end

bot.message(with_text: 'PlayRust') do |event|
  event.respond 'Pong!'
  bot.game = 'Rust'
  puts "got ping, putting pong"
end


puts "lul"
bot.run
