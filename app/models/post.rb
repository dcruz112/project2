class Post < ActiveRecord::Base
	belongs_to :user
	has_many :votes
	has_many :flags
	has_many :comments

	validates :content, presence: true

end
