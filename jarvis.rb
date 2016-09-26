require_relative "./environment.rb"

bot = Discordrb::Commands::CommandBot.new token: ENV["discord_token"], application_id: ENV["discord_app_id"].to_i, prefix: '/'


bot.command :dice do |event, min, max|

	rand(min.to_i .. max.to_i)
end

bot.command :role_me do |event, role|
	"your userid is: #{event.user.id}"
end

bot.run