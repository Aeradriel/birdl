# Model for Addresses
class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
  has_many :events

  def to_s
    "#{num} #{street}\n" \
    "#{zipcode} #{city}\n" \
    "#{country.name}"
  end
end
