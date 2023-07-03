class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :customer, type: :integer, foreign_key: true, null: false
      t.string :post_name,          null: false
      t.text :description,          null: false
      t.text :material,             null: false
      t.text :recipe,               null: false
      t.string :nutrition,          null: false

      t.timestamps
    end
  end
end
