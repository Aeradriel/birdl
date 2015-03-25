# Class model for achievements
class Achievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge

  # !TODO: Change updated at to "win date"
  scope :recent,
        lambda {
          where('updated_at > ? AND progression = 100',
                Time.now - 3.days)
        }
end
