class AddNameToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :name, :string, :default => ''
  end
end
