class Lecture < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :confusions
  has_many :posts
end
