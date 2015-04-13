# Model for GroupEvents
class GroupEvent < Event
  validates_presence_of :address
end
