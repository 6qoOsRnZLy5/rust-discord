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

bot.message(with_text: 'WatchOblivion') do |event|
  event.respond 'ok!'
  bot.watching = 'https://www.twitch.tv/obliviionhd'
  puts "watching obliviionhd"
end

bot.message(with_text: 'WatchBrechja') do |event|
  event.respond 'ok!'
  bot.watching = 'https://www.youtube.com/watch?v=Js6O-qwOXIA'
  puts "watching https://www.youtube.com/watch?v=Js6O-qwOXIA"
end

bot.message(with_text: 'ListenBrechja') do |event|
  event.respond 'ok!'
  bot.listening = 'https://www.youtube.com/watch?v=Js6O-qwOXIA'
  puts "listening https://www.youtube.com/watch?v=Js6O-qwOXIA"
end

bot.message(with_text: 'ListenAlive') do |event|
  event.respond 'ok!'
  bot.listening = 'https://open.spotify.com/track/3mRM4NM8iO7UBqrSigCQFH'
  puts "listening https://open.spotify.com/track/3mRM4NM8iO7UBqrSigCQFH"
end

puts "lul"
bot.run
