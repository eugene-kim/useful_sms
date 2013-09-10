desc "Get library hours"

task :fetch_lib_hours => :environment do

	require 'nokogiri'
	require 'open-uri'

	PAGE_URL = "http://www.lib.berkeley.edu/hours"

	page = Nokogiri::HTML(open(PAGE_URL))

	lib_rows = page.css('table.front tbody tr')

	library_hours = {}

	# rows i don't care about
	extraneous = ['Reference Service', 'Undergraduate Student Access', 'Circulation Desk', 'Privileges Desk', 'Research Advistory Service', 'Copy Services']

	lib_rows.each do |row|
		# Special Case for Doe Library since Main Stacks is a sub listing

		# remove sublistings (reference service)
		next if extraneous.include? row.css('td')[0].text.gsub("\n", '')

		lib_name  = row.css('td')[0].text.gsub("\n", '')
		lib_hours = row.css('td')[1].text.gsub("\n", '').gsub(/\s+/, '')
		library_hours[lib_name] = lib_hours
	end

	# my_libs = ['Berkeley Law Library', 'Bioscience & Natural Resources Library', 'Business Library', 'Gardner (MAIN) Stacks', 'East Asian Library', 'Engineering Library', 'Moffitt Library']

	library_hours.each do |name, hours|
		message = Message.find_by_description(name)
		if message
			message.update_attributes(body: hours)
		else
			Message.create!(body: hours, description: name)
		end
	end
end