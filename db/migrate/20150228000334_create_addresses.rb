class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :num
      t.string :street
      t.string :zipcode
      t.string :city
      t.belongs_to :country, index: true

      t.timestamps
    end
  end
end
