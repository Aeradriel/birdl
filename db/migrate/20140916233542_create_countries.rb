class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :language
      t.string :flag_path

      t.timestamps
    end
  end
end
