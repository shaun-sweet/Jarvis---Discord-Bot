require_relative "./environment.rb"
$dictionary = MWDictionaryAPI::Client.new(ENV["mw_key"], api_type: "collegiate")
bot = Discordrb::Commands::CommandBot.new token: ENV["discord_token"], application_id: ENV["discord_app_id"].to_i, prefix: '/'



bot.command :dice do |event, min, max|
	rand(min.to_i .. max.to_i)
end

bot.command :add do |event, user, role|
	if event.author.owner?	
		# checks for errors
		role = event.server.roles.find {|r| r.name == role} 
		member = event.server.members.find {|member| member.name == user}
		member.add_role role

		"#{event.author.username}, I've added #{member.name} to the #{role.name} group."
		
	else
		"Sir, it's my understanding you're not an admin..."
	end

	
end

bot.command :remove do |event, user, role|
	role = event.server.roles.find {|r| r.name == role} 
	member = event.server.members.find {|member| member.name == user}
	member.remove_role role
	"#{event.author.username}, I've removed #{member.name} from the #{role.name}'s."
end

bot.command :define do |event, word|	
		p response = $dictionary.search(word).entries[0][:definitions].first[:text][1..-1]
		response.slice(0..(response.index(":")) - 1)
end

bot.run