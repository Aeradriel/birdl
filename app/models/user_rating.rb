# UserRating model
class UserRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :giver, class_name: 'User'
end
