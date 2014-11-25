class AddAvailableToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :available, :boolean, :default => false
    add_column :countries, :i18n_key, :string
  end
end
