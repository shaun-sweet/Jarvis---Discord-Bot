require_relative './environment.rb'
def scrape(args = {})
	city = args[:city]
	query = args[:query]
	sort_by = args[:sort_by]
	base_url = "http://#{city}.craigslist.org"
	posting_url = "#{base_url}/search/jjj?sort=#{sort_by}&query=#{query}"
	web_page = Nokogiri::HTML(open(posting_url))
	web_page.css('.row').each do |job_posting|
		# this line figures out if the posting is the one i'm looking for
		url = job_posting.css('a').attribute('href').text
		unless url.start_with?("http://")
			scrape_config = {
				posting_details_page: "#{base_url}#{url}",
			}
			details_page = Nokogiri::HTML(open(scrape_config[:posting_details_page]))

			job_details = {
				date_posted: Date.parse(job_posting.css('time').attribute('datetime').text),
				title: job_posting.css('a').text,
				body: details_page.css('section #postingbody').text.gsub("\n", "").gsub("\t", ""),
				url: scrape_config[:posting_details_page]
			}
			if job_details[:date_posted] == Date.today
				Job.create(job_details)
			end
		end
	end
	puts "Completed scrape"
end

scrape query: "sales", city: "phoenix", sort_by: "date"