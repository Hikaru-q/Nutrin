class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.references :customer, type: :integer, foreign_key: true, null: false
      t.references :post, type: :integer, foreign_key: true, null: false
      t.text :comment,              null: false

      t.timestamps
    end
  end
end
