require_relative "./environment.rb"

bot = Discordrb::Commands::CommandBot.new token: ENV["discord_token"], application_id: ENV["discord_app_id"].to_i, prefix: 'jarvis '

bot.command :dice do |event, min, max|
	rand(min.to_i .. max.to_i)
end

bot.command :job do |event|
	todays_jobs = Job.where("date_posted = ?", Date.today)
	response = "Greetings sir... I have found a few jobs for you...\n"
	if todays_jobs.length > 0
		todays_jobs.each do |job|
		  response << job.title
		  response << "\n"
		  response << job.url
		  response << "\n"
	  	end
	  	event.respond response
	else
	  event.respond "Nothing yet today... I will keep watching!"
 	end
end


bot.command :weather do |event, city, parameter|
	weather = Weather.new city: city
	case parameter
	when "description"
		"The weather in #{city} is #{weather.description}"
	when "temperature"
		"The temperature in #{city} is #{weather.temperature}"
	when "range"
		"The maximum temperature in #{city} is #{weather.max} and the minimum temperature is #{weather.min}"
	else
		"The weather in #{city} is #{weather.description}, and the temperature is #{weather.temperature}"
	end
end

bot.run