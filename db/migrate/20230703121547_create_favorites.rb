class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :customer, type: :integer, foreign_key: true, null: false
      t.references :post, type: :integer, foreign_key: true, null: false

      t.timestamps
    end
  end
end
