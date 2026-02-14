class CreateArticleTags < ActiveRecord::Migration[8.1]
  def change
    create_table :article_tags do |t|
      t.references :article, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps

      t.index %i[article_id tag_id], unique: true
    end
  end
end
