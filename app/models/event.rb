# Class model for events
class Event < ActiveRecord::Base
  scope :face_to_face, -> { where(type: 'FaceToFace') }
  scope :group_event, -> { where(type: 'GroupEvent') }
  scope :online_chat, -> { where(type: 'OnlineChat') }
  scope :tourism_tour, -> { where(type: 'TourismTour') }
  scope :past, -> { where 'date < ?', Time.now }
  scope :future, -> { where 'date >= ?', Time.now }
  scope :soon,
        lambda {
          where('date > ? AND date <= ?', Time.now,
                Time.now + 3.days)
        }

  belongs_to :owner, class_name: 'User'
  belongs_to :address
  has_many :participations
  has_many :users, through: :participations

  validates :name, presence: true
  validates :type, presence: true
  validates :min_slots, presence: true
  validates :max_slots, presence: true
  validates :date, presence: true

  accepts_nested_attributes_for :address

  def self.type
    %w(FaceToFace GroupEvent OnlineChat TourismTour)
  end

  def remaining_slots
    max_slots - users.count
  end
end
