class AddInfosToEvents < ActiveRecord::Migration
  def change
    add_column :events, :language, :string
    add_column :events, :location, :string
  end
end
