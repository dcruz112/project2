class Lecture < ActiveRecord::Base
  belongs_to :user
  has_many :confusions
end
