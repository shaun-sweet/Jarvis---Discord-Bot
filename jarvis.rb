require 'discordrb'
require_relative "./environment.rb"


bot = Discordrb::Bot.new token: ENV["discord_token"], application_id: ENV["discord_app_id"].to_i
now = Date.today
bot.message with_text: 'job' do |event|
	todays_jobs = Job.where "date_posted = ?", now
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

bot.run

