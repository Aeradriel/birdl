class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.belongs_to :user
      t.belongs_to :badge

      t.timestamps
    end
  end
end