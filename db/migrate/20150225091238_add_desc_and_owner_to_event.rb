class AddDescAndOwnerToEvent < ActiveRecord::Migration
  def change
    add_column :events, :desc, :string
    add_reference :events, :owner, index: true, allow_nil: false
  end
end
