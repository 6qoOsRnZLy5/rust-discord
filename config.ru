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
roles["client"] = ENV["NOTIFY_STABLE_CLIENT_ROLE"].to_i
roles["server"] = ENV["NOTIFY_STABLE_SERVER_ROLE"].to_i
roles["client-beta"] = ENV["NOTIFY_STAGING_CLIENT_ROLE"].to_i
roles["news"] = ENV["NOTIFY_NEWS_ROLE"].to_i
roles["skins"] = ENV["NOTIFY_SKINS_ROLE"].to_i
roles["youtube"] = ENV["NOTIFY_YOUTUBE_ROLE"].to_i
roles["reddit"] = ENV["NOTIFY_REDDIT_ROLE"].to_i
roles["twitch"] = ENV["NOTIFY_TWITCH_ROLE"].to_i
allroles = roles.keys.join(" / ").to_s
ROLEDESC = String.new
ROLEDESC << "rolename    - get highlighted when.. \n"
ROLEDESC << "client      - .. a new rust version is avail. on steam\n"
ROLEDESC << "client-beta - .. a new rust staging version is avail. on steam\n"
ROLEDESC << "server      - .. a new rust server version is avail. on steam\n"
ROLEDESC << "news        - .. there are new news for rust published on steam (alpha)\n"
ROLEDESC << "skins       - .. there are new skins for rust released on steam (alpha)\n"
ROLEDESC << "youtube     - .. there are new youtube highlights (not implemented)\n"
ROLEDESC << "reddit      - .. there are new reddit highlights (not implemented)\n"
ROLEDESC << "twitch      - .. top streamers go live / top clips (not implemented)\n"

bot.command(:subscribe,
            min_args: 1,
            max_args: 1,
            description: 'assigns a role to a user, which is used for mentioning on certain events.',
            usage: "subscribe $role, role should be one of ( #{allroles} )\n#{ROLEDESC}") do |event, role|
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
