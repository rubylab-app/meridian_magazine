class CreateSubscribers < ActiveRecord::Migration[8.1]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false
      t.string :name
      t.boolean :confirmed, default: false, null: false
      t.datetime :confirmed_at
      t.timestamps

      t.index :email, unique: true
    end
  end
end
