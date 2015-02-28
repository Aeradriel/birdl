class AddAddressToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :address, index: true
  end
end
