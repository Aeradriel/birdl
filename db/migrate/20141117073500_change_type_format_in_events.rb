class ChangeTypeFormatInEvents < ActiveRecord::Migration
  def up
    change_column :events, :type, :string
  end

  def down
    change_column :events, :type, :integer
  end
end
