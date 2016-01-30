# Class model for users
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  belongs_to :country
  has_many :received_messages, foreign_key: :receiver_id, class_name: 'Message'
  has_many :sent_messages, foreign_key: :sender_id, class_name: 'Message'
  has_many :achievements
  has_many :participations
  has_many :badges, through: :achievements
  has_many :events, through: :participations
  has_many :user_ratings
  has_many :given_ratings, foreign_key: :giver_id, class_name: 'UserRating'
  # has_many :org_events, -> { where(events: { owner_id: 27 }) },
  # through: :participations, :class_name => "Event", :source => :event
  has_many :addresses

  has_many :relations
  has_many :friends, through: :relations

  has_many :inverse_relations, class_name: 'Relation', foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_relations, source: :user

  has_many :notifications

  scope :admins, -> { where(admin: true) }
  scope :normals, -> { where(admin: false) }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :validate_gender
  validate :validate_birthdate

  def gender_valid?
    false unless gender == 1 || gender == 0
    true
  end

  def name
    "#{first_name} #{last_name}"
  end

  def average_rating
    user_ratings.inject(0) { |a, e| a.to_f + e.value.to_f } / user_ratings.size
  end

  def organized_events
    events = []
    self.events.each do |e|
      events << e if e.owner == self
    end
    events
  end

  def fill(email, password, first_name, last_name)
    self.email = email
    self.password = password
    self.first_name = first_name
    self.last_name = last_name
  end

  protected

  def validate_gender
    errors.add(:gender, 'is invalid') if gender != 1 && gender != 0
  end

  def validate_birthdate
    valid = birthdate.nil? || birthdate > 18.years.ago ? false : true
    errors.add(:birthdate, 'is invalid') unless valid
  end

  def self.from_omniauth(auth)
    data = auth.info
    where(email: data.email).first_or_create do |user|
      user.fill(data.email, Devise.friendly_token[0, 20],
                data.first_name, data.last_name)
      user.birthdate = nil
      user.gender = auth.info.gender == 'male' ? 1 : 0
    end
  end
end
