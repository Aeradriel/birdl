# Class model for badges
class Badge < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  has_many :achievements
  has_many :badges, through: :achievements
end
