class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :subject, type: :bigint, polymorphic: true
      t.references :customer, type: :bigint, foreign_key: true, null: false
      t.integer :action_type, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
