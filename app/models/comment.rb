class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes
  has_many :flags
end
