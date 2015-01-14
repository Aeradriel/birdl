# Class model for countries
class Country < ActiveRecord::Base
  before_destroy :remove_from_users

  validates :language, presence: true
  validates :name, presence: true
  validate :check_i18n_key

  has_many :users

  private

  def check_i18n_key
    errors.add(:i18n_key, 'is invalid') if i18n_key.nil? if available
  end

  def remove_from_users
    users.each do |user|
      user.country = nil
    end
  end
end
