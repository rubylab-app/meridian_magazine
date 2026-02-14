class CreateNewsletters < ActiveRecord::Migration[8.1]
  def change
    create_table :newsletters do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.integer :status, default: 0, null: false
      t.datetime :sent_at
      t.integer :recipients_count, default: 0, null: false
      t.timestamps
    end
  end
end
