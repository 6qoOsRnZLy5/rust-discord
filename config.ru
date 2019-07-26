require 'discordrb'
require 'rack'

bot_id = ENV['DISCORD_ID']
bot_secret = ENV['DISCORD_SECRET']

bot = Discordrb::Commands::CommandBot.new token: bot_secret, client_id: bot_id, prefix: '!'

USAGE = "!ping - a ping is usually followed by pong, "
USAGE << "!subscribe - get mentioned when rust updates, "
USAGE << "!commands - the message you are looking at"

bot.command :ping do |event|
  event.channel.start_typing
  sleep 1
  "Pong u #{event.author.mention} !"
end


roles = Hash.new
roles["rust-client"] = ENV["NOTIFY_STABLE_CLIENT_ROLE"].to_i
roles["rust-server"] = ENV["NOTIFY_STABLE_SERVER_ROLE"].to_i
roles["rust-client-beta"] = ENV["NOTIFY_STAGING_CLIENT_ROLE"].to_i
roles["rust-skins"] = ENV["NOTIFY_SKINS_ROLE"].to_i
roles["rust-youtube"] = ENV["NOTIFY_YOUTUBE_ROLE"].to_i
roles["rust-reddit"] = ENV["NOTIFY_REDDIT_ROLE"].to_i
roles["rust-twitch"] = ENV["NOTIFY_TWITCH_ROLE"].to_i
allroles = roles.keys.join(", ").to_s

bot.command(:subscribe,
            min_args: 1,
            max_args: 1,
            description: 'assigns a role to a user, which is used for mentioning on certain events.',
            usage: "subscribe $role, role should be one of #{allroles}") do |event, role|
  if roles[role]
    event.channel.start_typing
    sleep 1
    event.author.add_role(roles[role], 'user request')
    "u should be subscribed to updates for #{role} now, #{event.author.mention} !"
  else
    event.channel.start_typing
    sleep 1
    "the role #{role} does not exist, #{event.author.mention} !"
  end
end

bot.command :commands do | event |
  event.channel.start_typing
  sleep 1
  event.respond "#{event.author.mention}:\n!ping - ususally followed by pong\n!subscribe subscrribes to updates."
end


puts "lul"
#bot.run

bot.run(true)
puts "bot started.."

sleep 1
bot.game = 'Rust'
#bot.send_message(601755089845354556, 'Bot is now active!')
bot.join
