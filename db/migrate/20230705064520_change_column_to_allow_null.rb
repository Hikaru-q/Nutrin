class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def up
    change_column :customers, :introduction, :text, null: true
  end

  def down
    change_column :customers, :introduction, :text, null: false
  end
end
