# Model for Addresses
class Address < ActiveRecord::Base
  belongs_to :country
end
