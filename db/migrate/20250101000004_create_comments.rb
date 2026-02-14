class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :author_name, null: false
      t.string :author_email, null: false
      t.integer :status, default: 0, null: false
      t.references :article, null: false, foreign_key: true
      t.datetime :deleted_at
      t.timestamps

      t.index :status
      t.index :deleted_at
    end
  end
end
