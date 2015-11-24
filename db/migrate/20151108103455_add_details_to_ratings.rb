class AddDetailsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :value, :float
    add_column :ratings, :comment, :text
  end
end
