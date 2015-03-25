class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :giver, index: true
      t.integer :value

      t.timestamps
    end
  end
end
