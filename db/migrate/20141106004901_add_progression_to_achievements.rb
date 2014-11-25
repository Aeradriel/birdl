class AddProgressionToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :progression, :integer, :default => 0
  end
end
