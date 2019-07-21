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
  event.respond 'ok!'
  bot.game = 'Rust'
  puts "playing rust now"
end



# bot.stream('Watching Twitch', 'https://www.twitch.tv/obliviionhd')



puts "lul"
bot.run

# bot.run :async
