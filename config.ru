require 'discordrb'
require 'rack'

bot_id = ENV['DISCORD_ID']
bot_secret = ENV['DISCORD_SECRET']

bot = Discordrb::Bot.new token: bot_secret, client_id: bot_id

USAGE = "!ping - a ping is usually followed by pong, "
USAGE << "!subscribe - get mentioned when rust updates, "
USAGE << "!commands - the message you are looking at"

bot.message(with_text: '!ping') do |event|
  event.channel.start_typing
  sleep 1
  event.respond "Pong u #{event.author.mention} !"
  puts " ---- got ping, putting pong"
  puts event.inspect
  puts "----------------------------"
end

bot.message(with_text: '!subscribe') do |event|
  event.channel.start_typing
  sleep 1
  event.author.add_role(603765106584715285, 'bot')
  event.respond "u should be subscribed to updates for rust now, #{event.author.mention} !"
end

bot.message(with_text: '!commands') do |event|
  event.channel.start_typing
  sleep 1
  event.respond "#{event.author.mention}: #{USAGE}"
end
# bot.stream('Watching Twitch', 'https://www.twitch.tv/obliviionhd')



puts "lul"
#bot.run

bot.run(true)
puts "bot started.."

sleep 1
bot.game = 'Rust'
#bot.send_message(601755089845354556, 'Bot is now active!')
bot.join
