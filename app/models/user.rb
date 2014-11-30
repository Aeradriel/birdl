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

  scope :admins, -> { where(admin: true) }
  scope :normals, -> { where(admin: false) }

  validates :first_name, presence: true, allow_nil: false, allow_blank: false
  validates :last_name, presence: true, allow_nil: false, allow_blank: false
  validates :birthdate, presence: true, allow_nil: false, allow_blank: false
  validate :validate_gender
  validate :validate_birthdate

  def gender_valid?
    false unless gender == 1 || gender == 0
    true
  end

  def name
    "#{first_name} #{last_name}"
  end

  protected

  def validate_gender
    errors.add(:gender, 'is invalid') if gender != 1 && gender != 0
  end

  def validate_birthdate
    valid = birthdate.nil? || birthdate > 18.years.ago ? false : true
    errors.add(:birthdate, 'is invalid') unless valid
  end
end
