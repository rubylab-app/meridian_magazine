class AddPhase3DisplayColumns < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :website, :string
    add_column :categories, :color, :string
    add_column :newsletters, :sponsorship_amount, :decimal, precision: 10, scale: 2
  end
end
