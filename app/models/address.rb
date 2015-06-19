# Model for Addresses
class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
  has_many :events

  def to_s
    addr = "#{num} #{street}\n" \
    "#{zipcode} #{city}\n"
    addr += country.name if country
    addr
  end
end
