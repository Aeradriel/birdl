# Class model for users
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :country
  has_many :received_messages, -> { where sent: true },
           foreign_key: :receiver_id, class_name: 'Message'
  has_many :sent_messages, -> { where sent: true },
           foreign_key: :sender_id, class_name: 'Message'
  has_many :draft_messages, -> { where sent: false },
           foreign_key: :sender_id, class_name: 'Message'
  has_many :achievements
  has_many :participations
  has_many :badges, through: :achievements
  has_many :events, through: :participations

  validates :first_name, presence: true, allow_nil: false, allow_blank: false
  validates :last_name, presence: true, allow_nil: false, allow_blank: false
  validates :birthdate, presence: true, allow_nil: false, allow_blank: false
  validate :gender_is_correct

  def gender_is_correct
    errors.add(:gender, 'is invalid') if gender != 1 && gender != 0
  end
end
