class Notification < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :text
  validates_presence_of :subject
end
