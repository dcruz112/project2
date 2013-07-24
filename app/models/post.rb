class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :lecture
	has_many :votes
	has_many :flags
	has_many :comments

	validates :content, presence: true

end
