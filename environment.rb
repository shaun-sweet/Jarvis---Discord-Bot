require 'open-uri'
require 'date'
require 'active_record'
require 'sqlite3'
require 'nokogiri'
require './apikeys.rb'
ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	username: 'root',
	password: 'password',
	database: 'jobs'
)
# requires all files in lib folder
require_relative './lib/jobs.rb'
Dir.glob('./lib/*.rb').each do |ruby_file|
	require ruby_file
end



