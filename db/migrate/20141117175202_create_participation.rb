class CreateParticipation < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end
end