class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :sender, index: true
      t.belongs_to :receiver, index: true
      t.string :object
      t.string :content
      t.boolean :sent, default: false
      t.date :sent_at

      t.timestamps
    end
  end
end
