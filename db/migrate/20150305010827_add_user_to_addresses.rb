class AddUserToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :user, index: true
  end
end
