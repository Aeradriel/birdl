class AddFbAccToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_acc, :boolean, default: false
  end
end
