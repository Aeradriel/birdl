# Class model for events
class Event < ActiveRecord::Base
  scope :face_to_face, -> { where(type: 'FaceToFace') }
  scope :group_event, -> { where(type: 'GroupEvent') }
  scope :online_chat, -> { where(type: 'OnlineChat') }
  scope :tourism_tour, -> { where(type: 'TourismTour') }

  has_many :participations
  has_many :users, through: :participations

  validates :name, presence: true, allow_blank: false, allow_nil: false
  validates :type, presence: true, allow_nil: false, allow_blank: false
  validates :min_slots, presence: true, allow_nil: false
  validates :max_slots, presence: true, allow_nil: false
  validates :date, presence: true, allow_nil: false

  def self.type
    %w(FaceToFace OnlineChat TourismTour)
  end
end
