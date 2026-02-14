class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.text :excerpt
      t.integer :status, default: 0, null: false
      t.boolean :featured, default: false, null: false
      t.datetime :published_at
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.datetime :deleted_at
      t.timestamps

      t.index :status
      t.index :featured
      t.index :published_at
      t.index :deleted_at
    end
  end
end
