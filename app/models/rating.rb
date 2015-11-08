# Class for ratings
class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :giver, class_name: 'User'
  belongs_to :event

  validates_presence_of :value
  validates_presence_of :user
  validates_presence_of :giver
  validates_presence_of :event
end
