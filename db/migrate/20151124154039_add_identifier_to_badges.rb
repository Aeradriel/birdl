class AddIdentifierToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :identifier, :string
  end
end
