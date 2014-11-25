# Class model for events
class Event < ActiveRecord::Base
  scope :face_to_face, -> { where(type: 'FaceToFace') }
  scope :online_chat, -> { where(type: 'OnlineChat') }
  scope :tourism_tour, -> { where(type: 'TourismTour') }

  has_many :participations
  has_many :users, through: :participations

  def self.type
    %w(FaceToFace OnlineChat TourismTour)
  end
end
