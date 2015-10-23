class AddDefaultStatusToOrder < ActiveRecord::Migration
  def up
    change_column :orders, :status, :integer, default: 0, null: false
  end

  def down
    change_column :orders, :status, :integer, default: nil
  end
end
