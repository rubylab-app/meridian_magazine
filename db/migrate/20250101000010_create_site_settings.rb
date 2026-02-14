class CreateSiteSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :site_settings do |t|
      t.string :key, null: false
      t.text :value
      t.text :description
      t.integer :setting_type, default: 0, null: false
      t.timestamps

      t.index :key, unique: true
    end
  end
end
