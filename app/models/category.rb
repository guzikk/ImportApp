class Category < ActiveRecord::Base
	has_many :links
	has_many :operations, through: :links		
	validates_presence_of :name
end
