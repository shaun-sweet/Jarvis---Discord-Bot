require_relative "./environment.rb"

bot = Discordrb::Commands::CommandBot.new token: ENV["discord_token"], application_id: ENV["discord_app_id"].to_i, prefix: 'jarvis '


bot.command :dice do |event, min, max|
	rand(min.to_i .. max.to_i)
end

bot.run