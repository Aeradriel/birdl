class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :type
      t.integer :min_slots
      t.integer :max_slots
      t.datetime :date
      t.datetime :end

      t.timestamps
    end
  end
end
