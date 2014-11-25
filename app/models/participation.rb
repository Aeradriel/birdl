# Class model for participations to events
class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
