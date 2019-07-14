use Rack::Reloader, 0  
use Rack::ContentLength

bot_id = ENV['DISCORD_ID']
bot_secret = ENV['DISCORD_SECRET']

bot = Discordrb::Bot.new token: bot_secret, client_id: bot_id


bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
  puts "got ping, putting pong"
end

bot.run
