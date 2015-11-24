class AddEventToRatings < ActiveRecord::Migration
  def change
    add_reference :ratings, :event, index: true
  end
end
