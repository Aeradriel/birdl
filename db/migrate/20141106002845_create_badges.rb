class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.string :icon_path

      t.timestamps
    end
  end
end
