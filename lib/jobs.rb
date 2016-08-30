class Job < ActiveRecord::Base
	validates :url, uniqueness: true
end