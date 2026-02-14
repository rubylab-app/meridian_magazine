class CreatePages < ActiveRecord::Migration[8.1]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.integer :status, default: 0, null: false
      t.integer :position, default: 0, null: false
      t.timestamps

      t.index :slug, unique: true
    end
  end
end
