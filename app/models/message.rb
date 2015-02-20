# Class model for Messages
class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }

  validates :sender, presence: true, allow_nil: false
  validates :sender, presence: true, allow_nil: false
  validates :object, presence: true, allow_nil: false, allow_blank: false
  validates :content, presence: true, allow_nil: false, allow_blank: false

  def draft?
    !sent
  end

  def send_message
    self.sent = true
    self.sent_at = Time.now
    # TODO: Notify receiver
  end
end
