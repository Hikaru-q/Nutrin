class AddAdminToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :admin, :boolean, default: false, null: false
  end
end
