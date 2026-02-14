class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :role, default: 0, null: false
      t.text :bio
      t.string :avatar_url
      t.boolean :active, default: true, null: false
      t.timestamps

      t.index :email, unique: true
    end
  end
end
