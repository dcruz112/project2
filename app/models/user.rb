class User < ActiveRecord::Base
	has_many :posts
	has_many :votes
	has_many :flags
	has_many :comment

	def full_name
		first_name + " " + last_name
	end
end
