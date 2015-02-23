class UserRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :giver, class_name: 'User'
end
